#!/bin/bash

source $(dirname $0)/docker-common.sh

prepare

sudo docker run --rm --net=host $MOUNTS -i -t $DOCKER_IMAGE /bin/bash
