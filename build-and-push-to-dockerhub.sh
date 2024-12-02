#!/bin/bash

# exit when any command fails:
set -e
# line by line tracing
#set -x

function usage {
  echo "Usage: $(basename $0) [--push] <fcrepo-x.y.z.war> <tags>+"
  echo "    --push : push the built images to hub.docker.com"
  echo "    <fcrepo-x.y.z.war> : path to the fcrepo war file to build with"
  echo "    <tags> : one or more tags for the image (must not be 'latest' or empty"
}


if [ $# -lt 1 ]; then
  usage
  exit 1
fi
PUSH=0
if [ $# -ge 1 ]; then
  for opt in "$@"; do
    case $opt in
      "-h"|"--help")
        usage
        exit 1
        ;;
      "--push")
        PUSH=1
        ;;
     esac
  done
fi

if [ $PUSH -eq 1 ]; then
  FCREPO_WEBAPP_FULL_PATH="$2"
  TAGS=( "${@:3}" )
else
  FCREPO_WEBAPP_FULL_PATH="$1"
  TAGS=( "${@:2}" )
fi

FCREPO_WEBAPP_FILE=$(basename "$FCREPO_WEBAPP_FULL_PATH")

for docker_tag in "${TAGS[@]}"
do
    # Check that valid tag is supplied. If not, fail
    if [ "latest" == "${docker_tag}" ] || [ -z "${docker_tag}" ]
    then
        echo "Building latest or empty tags is no longer supported"
        exit 1
    fi
done

if [ -d ./webapp ]; then
    rm -r ./webapp
fi
# Extract the webapp into subdirectory webapp:
mkdir ./webapp
unzip -q -d ./webapp "$FCREPO_WEBAPP_FULL_PATH"

if [ $PUSH -eq 1 ]; then
    # authenticate with docker hub and then push images:
    echo -n "Enter hub.docker.com username ->"
    read DOCKER_USERNAME
    echo -n "Enter hub.docker.com password ->"
    read -s DOCKER_PASSWORD
    echo ""
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    docker buildx create --use > /dev/null
fi
platforms=linux/arm64,linux/amd64

# build and push images
for docker_tag in "${TAGS[@]}"
do
    if [ $PUSH -eq 1 ]; then
        echo -n "Building and pushing $docker_tag ..."
        docker buildx build --quiet --platform ${platforms} --push -t fcrepo/fcrepo:$docker_tag .
        echo " complete ($docker_tag)"
    else
        echo -n "Building  $docker_tag ..."
        docker buildx build --quiet --platform ${platforms} -t fcrepo/fcrepo:$docker_tag .
        echo " complete ($docker_tag)"
    fi
done
