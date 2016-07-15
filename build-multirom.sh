#!/bin/bash

source ./fairphone_jenkins/common.sh

cd /var/fairphone_os/android

make -j10 multirom_zip

if [ ! -f out/target/product/FP2/multirom* ]; then
        echo "Compilation failed."
else
        echo "Compilation finished"
        cp out/target/product/FP2/multirom* /var/out/
fi
