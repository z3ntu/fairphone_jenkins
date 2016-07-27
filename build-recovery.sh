#!/bin/bash

source $(dirname $0)/build-common.sh

cd /var/fairphone_os/android

make -j10 recoveryimage

if [ ! -f out/target/product/FP2/TWRP_*_multirom_FP2_*.img ]; then
        echo "Compilation failed."
else
        echo "Compilation finished"
	filename=$(basename out/target/product/FP2/TWRP_*_multirom_FP2_*.img)
	echo "Multirom TWRP recovery $filename is finished!"
	cp out/target/product/FP2/$filename /var/out/
fi
