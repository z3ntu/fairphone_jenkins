#!/bin/bash

sudo docker run --rm --net=host -v /home/jenkins/workspace/Kernel/:/var/fairphone_os/ -i jftr/fairphone2-build-env /bin/bash -c "curl -O https://raw.githubusercontent.com/z3ntu/fairphone_jenkins/master/build-kernel.sh && chmod +x build-kernel.sh && ./build-kernel.sh"
