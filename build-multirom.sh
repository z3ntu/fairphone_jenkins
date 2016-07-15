#!/bin/bash

./common.sh

make -j10 multirom_zip

ls -al out/target/product/FP2/

if [ ! -f out/target/product/FP2/multirom* ]; then
        echo "Compilation failed."
else
        echo "Compilation finished"
        cp out/target/product/FP2/multirom* /var/out/
fi
