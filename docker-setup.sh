#!/bin/bash

echo "Starting Docker..."

echo "Pulling down docker image."
sudo docker pull jftr/fairphone2-build-env

echo "Running docker image."
#sudo docker run --rm --net=host -v /home/jenkins/workspace/Kernel/:/var/fairphone_os/ --entrypoint='/bin/bash -c "if [ -d fairphone_jenkins/ ]; then git -C fairphone_jenkins/ pull; else git clone https://github.com/z3ntu/fairphone_jenkins; fi; ./fairphone_jenkins/build-kernel.sh"' jftr/fairphone2-build-env 
sudo docker run --rm --net=host -v /home/jenkins/workspace/Kernel/:/var/fairphone_os/ jftr/fairphone2-build-env /bin/bash -c "if [ -d fairphone_jenkins/ ]; then git -C fairphone_jenkins/ pull; else git clone https://github.com/z3ntu/fairphone_jenkins; fi; ./fairphone_jenkins/build-kernel.sh"
