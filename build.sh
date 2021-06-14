#!/bin/bash

# Builds a local docker image

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

docker build --tag fcrepo/fcrepo .
