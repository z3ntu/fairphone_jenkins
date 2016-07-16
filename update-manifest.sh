#!/bin/bash

basepath="/home/jenkins/workspace/out"

echo "updating manifest"
multirom_filename=$(ls -t $basepath/multirom-*-UNOFFICIAL-FP2.zip | head -1)
recovery_filename=$(ls -t $basepath/TWRP_*_multirom_FP2_*.img | head -1)

echo $multirom_filename $recovery_filename
