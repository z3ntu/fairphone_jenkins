#!/bin/bash

if [ ! -d "efidroid/" ]; then
	mkdir efidroid/
	cd efidroid/
	echo "Initialising repo"
	repo init -u https://github.com/efidroid/manifest.git -b master
	mkdir -p .repo/local_manifests
	ln -s ../manifests/optional.xml .repo/local_manifests/optional.xml
	repo sync -j4 -c -f

	echo "Add device tree"
	git clone https://github.com/z3ntu/device -b fairphone/fp2 device/fairphone/fp2
else
	cd efidroid/
	echo "Pulling new changes"
	repo sync -j4 -c -f
	git -C device/fairphone/fp2 pull
fi

echo "Cleaning up"
make -j4 distclean

source build/envsetup.sh

# I use these variables instead of the command "lunch"
export BUILDTYPE=RELEASE
export DEVICEID=fairphone/fp2

make -j9 uefi
make -j9 otapackage
cp out/target/fairphone/fp2/otapackage-*-fairphone_fp2.zip /var/out/

#echo "Cleaning up"
#make -j4 distclean
