#!/bin/bash

DOCKER_IMAGE="z3ntu/fairphone2-build-env-with-vim"

echo "Starting Docker..."

echo "Pulling down docker image."
sudo docker pull $DOCKER_IMAGE

echo "Running docker image."
mkdir -p /home/jenkins/workspace/common/

sudo docker run --rm --net=host -v /home/jenkins/workspace/common/:/var/fairphone_os/ -v /home/jenkins/workspace/out/:/var/out/ $DOCKER_IMAGE /bin/bash -c "if [ -d fairphone_jenkins/ ]; then git -C fairphone_jenkins/ pull; else git clone https://github.com/z3ntu/fairphone_jenkins; fi; ./fairphone_jenkins/build-recovery.sh"
