#!/bin/bash

echo "Building the Fairphone 2 Kernel in Docker."

cd /var/fairphone_os/

if [ ! -d "android/" ]; then
	mkdir android/
	cd android/
	echo "Initialising repo"
	repo init -u https://github.com/z3ntu/android_manifest_fairphone_fp2 -b multirom
	# Add multirom
	git clone https://github.com/z3ntu/multirom.git system/extras/multirom
	git -C system/extras/multirom/ submodule update --init
else
	cd android/
fi

if [ ! -d "/var/fairphone_os/ccache" ]; then
	mkdir /var/fairphone_os/ccache
	prebuilts/misc/linux-x86/ccache/ccache -M 100G
fi

echo "Pulling new changes"
repo sync -j10 -c -f

echo "Cleaning up"
make -j10 clean

source build/envsetup.sh

choosecombo 1 FP2 2

export USE_CCACHE=1
export CCACHE_DIR=/var/fairphone_os/ccache
