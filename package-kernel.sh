#!/bin/bash

function package_kernel() {
  script_dir=$(dirname $0)
  mkdir $script_dir/tmp
  cp $kernel_filename $script_dir/tmp/boot.img
  cp -r $script_dir/META-INF $script_dir/tmp
  # TODO : Add signing, see http://android.stackexchange.com/a/36270/112176
  # Replace .img ending with .zip but retain name and set path to new location
  kernel_filename=$repopath/kernel/$(basename ${kernel_filename/\.img/\.zip})
  # Pack boot.img and the META-INF directory into the repo path
  apack $kernel_filename $script_dir/tmp/boot.img $script_dir/tmp/META-INF
  rm -r $script_dir/tmp
}
