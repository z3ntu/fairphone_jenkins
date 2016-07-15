#!/bin/bash

./fairphone_jenkins/common.sh

make -j10 multirom_zip

ls -al out/target/product/FP2/
ls -al
pwd

if [ ! -f out/target/product/FP2/multirom* ]; then
        echo "Compilation failed."
else
        echo "Compilation finished"
        cp out/target/product/FP2/multirom* /var/out/
fi
