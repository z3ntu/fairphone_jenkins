#!/bin/bash

echo "Updating multirom repo."

outpath="/home/jenkins/workspace/out"
repopath="/home/jenkins/multirom_fairphone_fp2"

if [ ! -d $repopath ]; then
  git clone git@multirom.github.com:z3ntu/multirom_fairphone_fp2.git $repopath
else 
  git -C $repopath pull
fi

multirom_filename=$(ls -t $outpath/multirom-*-UNOFFICIAL-FP2.zip | head -1)
recovery_filename=$(ls -t $outpath/TWRP_*_multirom_FP2_*.img | head -1)
# kernel_filename=$(ls -t $outpath/fairphone-2-kernel-*.img | head -1)
# TODO Also add uninstaller (+Jenkins recipe)
# TODO Maybe update the _filename variables to repopath location (except kernel_filename which already is)

echo "Cleaning $repopath/installer/"
rm $repopath/installer/*
echo "Copying $(basename $multirom_filename) to repo."
cp $multirom_filename $repopath/installer

echo "Cleaning $repopath/recovery/"
rm $repopath/recovery/*
echo "Copying $(basename $recovery_filename) to repo."
cp $recovery_filename $repopath/recovery

# echo "Cleaning $repopath/kernel/"
# rm $repopath/kernel/*
# echo "Packaging kernel $(basename $kernel_filename)."

# source $(dirname $0)/package-kernel.sh 
# package_kernel

manifest_content=$(python /home/jenkins/fairphone_jenkins/generate-manifest.py $multirom_filename $recovery_filename $kernel_filename)
echo -n $manifest_content > "$repopath/manifest.json"

echo "Updated manifest. Committing and pushing!"
git -C $repopath add $repopath
export GIT_AUTHOR_NAME="Jenkins"
export GIT_AUTHOR_EMAIL="noreply@z3ntu.xyz"
git -c "user.name=Luca Weiss" -c "user.email=z3ntu@z3ntu.xyz" -C $repopath commit -m "MultiROM FP2"
# Uncomment the following comments to squash to one commit
# git reset $(git commit-tree HEAD^{tree} -m "MultiROM FP2")
git -C $repopath push # --force
