#!/bin/bash

echo "Building the Fairphone 2 Kernel in Docker."

cd /var/fairphone_os/

if [ -d "android/" ]; then
	mkdir android/
	cd android/
	echo "Initialising repo"
	repo init -u https://github.com/z3ntu/android_manifest_fairphone_fp2 -b multirom
else
	cd android/
fi

if [ -d "out/" ]; then
	mkdir out/
fi

echo "Pulling new changes"
repo sync -j10 -c -f

echo "Cleaning up"
make -j10 clean

source build/envsetup.sh

choosecombo 1 FP2 2

make -j10 bootimage

if [ ! -f out/target/product/FP2/boot.img ];
	echo "Compilation failed."
else
	echo "Compilation finished"
	cp out/target/product/FP2/boot.img /var/fairphone_os/out/boot-$(git -C kernel/ rev-parse --short HEAD)-$(date -u +%Y-%m-%d).img
fi

echo "Script finished."
