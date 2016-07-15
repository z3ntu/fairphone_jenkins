#!/bin/bash

./fairphone_jenkins/common.sh

make -j10 bootimage

if [ ! -f out/target/product/FP2/boot.img ]; then
        echo "Compilation failed."
else
        echo "Compilation finished"
        cp out/target/product/FP2/boot.img /var/out/fairphone-2-kernel-$(git -C kernel/ rev-parse --short HEAD)-$(date -u +%Y-%m-%d).img
fi


