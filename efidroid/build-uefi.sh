#!/bin/bash

if [ ! -d "efidroid/" ]; then
	mkdir efidroid/
	cd efidroid/
	echo "Initialising repo"
	repo init -u https://github.com/efidroid/manifest.git -b master
    
    echo "Add device tree"
    git clone https://github.com/z3ntu/device -b fairphone/fp2 device/fairphone/fp2
else
	cd efidroid/
fi

echo "Pulling new changes"
#git -C .repo/manifests pull # somehow repo crashes when the manifest is updated, manually pulling fixes it
repo sync -j4 -c -f
git -C device/fairphone/fp2 pull

echo "Cleaning up"
make -j4 distclean

source build/envsetup.sh

lunch 1 1
make -j9 uefi
make -j9 otapackage
