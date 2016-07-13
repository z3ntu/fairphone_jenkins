#!/bin/bash

sudo docker run --rm --net=host -v /home/jenkins/workspace/Kernel/:/var/fairphone_os/ -i jftr/fairphone2-build-env /bin/bash -c "if [ -d fairphone_jenkins/ ]; then git pull; else git clone https://github.com/z3ntu/fairphone_jenkins; fi; ./fairphone_jenkins/build-kernel.sh"

