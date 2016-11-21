#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide the target device like \"fairphone/fp2\"!"
    exit 1
fi

DEVICE=$1

cd ../ # build outside of the jenkins build environment that we have one common folder
if [ ! -d "efidroid/" ]; then
	mkdir efidroid/
	cd efidroid/
	echo "Initialising repo"
	repo init -u https://github.com/efidroid/manifest.git -b master
	mkdir -p .repo/local_manifests
	ln -s ../manifests/optional.xml .repo/local_manifests/optional.xml
	repo sync -j4 -c -f
else
	cd efidroid/
	echo "Pulling new changes"
	repo sync -j4 -c -f
fi

if [ ! -d "device/$DEVICE" ]; then
	echo "Add device tree"
	git clone https://github.com/efidroid/device -b $DEVICE device/$DEVICE
else
	git -C device/$DEVICE pull
fi

echo "Cleaning up"
make -j4 distclean

source build/envsetup.sh

# I use these variables instead of the command "lunch"
export BUILDTYPE=RELEASE
export DEVICEID=$DEVICE

make -j9 uefi
make -j9 otapackage
DEVICE_UNDERSCORE=${DEVICE/\//_}
cp out/target/$DEVICE/otapackage-*-$DEVICE_UNDERSCORE.zip /var/out/
cp out/target/$DEVICE/otapackage-*-$DEVICE_UNDERSCORE.zip ../$DEVICE_UNDERSCORE/

#echo "Cleaning up"
#make -j4 distclean
