# exit when any command fails:
set -e

# authenticate with docker hub and then push images:
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

for docker_tag in "$@"
do
    if [ "latest" == $docker_tag ]
    then
        docker push fcrepo/fcrepo
    else
        docker tag fcrepo/fcrepo fcrepo/fcrepo:$docker_tag

        docker push fcrepo/fcrepo:$docker_tag
    fi
done
