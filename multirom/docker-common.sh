#!/bin/bash

DOCKER_IMAGE="z3ntu/fairphone2-build-env-with-vim"
MOUNTS="-v /home/jenkins/workspace/common/:/var/fairphone_os/ -v /home/jenkins/workspace/out/:/var/out/"

function prepare() { 
  echo "Pulling down docker image."
  sudo docker pull $DOCKER_IMAGE

  mkdir -p /home/jenkins/workspace/common/
}

function start_docker() {
  ACTION=$1
  echo "Starting Docker with action $ACTION"

  prepare

  echo "Running docker image."
  sudo docker run --rm --net=host $MOUNTS $DOCKER_IMAGE /bin/bash -c "if [ -d fairphone_jenkins/ ]; then git -C fairphone_jenkins/ pull; else git clone https://github.com/z3ntu/fairphone_jenkins; fi; ./fairphone_jenkins/$ACTION.sh"
}

# vim:set ts=2 sw=2 et:
