#!/bin/bash

source ./fairphone_jenkins/common.sh

cd /var/fairphone_os/android

make -j10 multirom_zip

if [ ! -f out/target/product/FP2/multirom-*-UNOFFICIAL-FP2.zip ];
        echo "Compilation failed."
else
        echo "Compilation finished"
	filename=$(basename out/target/product/FP2/multirom-*-UNOFFICIAL-FP2.zip)
	echo "Multirom $filename is finished!"
	cp out/target/product/FP2/$filename /var/out/
        cp out/target/product/FP2/$filename.md5sum /var/out/
fi
