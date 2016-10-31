#!/bin/bash

export USE_CCACHE=1
export CCACHE_DIR=/var/ccache

echo "Building in Docker."

cd /var/fairphone_os/

if [ ! -d "android/" ]; then
	mkdir android/
	cd android/
	echo "Initialising repo"
	repo init -u https://github.com/lj50036/platform_manifest_twrp_omni -b twrp-5.1
else
	cd android/
fi

echo "Pulling new changes"
git -C .repo/manifests pull # somehow repo crashes when the manifest is updated, manually pulling fixes it
repo sync -j10 -c -f

echo "Cleaning up"
make -j10 clean

source build/envsetup.sh

choosecombo 1 FP2 2
