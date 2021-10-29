#!/bin/bash

# exit when any command fails:
set -e

FCREPO_WEBAPP_FULL_PATH="$1"
FCREPO_WEBAPP_FILE=$(basename "$FCREPO_WEBAPP_FULL_PATH")

if [ -d ./webapp ]; then
    rm -r ./webapp
fi
# Extract the webapp into subdirectory webapp:
mkdir ./webapp
unzip -q -d ./webapp "$FCREPO_WEBAPP_FULL_PATH"

# authenticate with docker hub and then push images:
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker buildx create --use
platforms=linux/arm64,linux/amd64

# build and push images
for docker_tag in "${@:2}"
do
    echo "Building and pushing $docker_tag ..."
    if [ "latest" == $docker_tag ]
    then
        docker buildx build --platform ${platforms} --push  -t fcrepo/fcrepo .
	
    else
 	docker buildx build --platform ${platforms} --push  -t fcrepo/fcrepo:$docker_tag .
    fi

    echo "Build and push complete for $docker_tag"
done
