#!/bin/bash

echo "Updating multirom repo."

outpath="/home/jenkins/workspace/out"
repopath="/home/jenkins/multirom_fairphone_fp2"

if [ ! -d $repopath ]; then
	git clone git@multirom.github.com:z3ntu/multirom_fairphone_fp2.git $repopath
fi

multirom_filename=$(ls -t $outpath/multirom-*-UNOFFICIAL-FP2.zip | head -1)
recovery_filename=$(ls -t $outpath/TWRP_*_multirom_FP2_*.img | head -1)
kernel_filename=$(ls -t $outpath/fairphone-2-kernel-*.img | head -1)
# TODO Also add uninstaller and possibly the kernel (if I get to know how to package that)

echo "Cleaning $repopath/installer/"
rm $repopath/installer/*
echo "Copying $(basename $multirom_filename) to repo."
cp $multirom_filename $repopath/installer

echo "Cleaning $repopath/recovery/"
rm $repopath/recovery/*
echo "Copying $(basename $recovery_filename) to repo."
cp $recovery_filename $repopath/recovery

echo "Cleaning $repopath/kernel/"
rm $repopath/kernel/*
echo "Copying $(basename $kernel_filename) to repo."
cp $kernel_filename $repopath/kernel

manifest_content=$(python generate-manifest.py $multirom_filename $recovery_filename)
echo -n $manifest_content > "$repopath/manifest.json"

echo "Updated manifest. Committing and pushing!"
git -C $repopath add $repopath
git -c "user.name=Jenkins (z3ntu)" -c "user.email=noreply@z3ntu.xyz" -C $repopath commit -m "MultiROM FP2"
git -C $repopath push
