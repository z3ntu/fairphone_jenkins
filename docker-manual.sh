#!/bin/bash

DOCKER_IMAGE="z3ntu/fairphone2-build-env-with-vim"

echo "Starting Docker..."

echo "Pulling down docker image."
sudo docker pull $DOCKER_IMAGE

echo "Running docker image."
mkdir -p /home/jenkins/workspace/common/

sudo docker run --rm --net=host -v /home/jenkins/workspace/common/:/var/fairphone_os/ -v /home/jenkins/workspace/out/:/var/out/ -i -t $DOCKER_IMAGE /bin/bash
