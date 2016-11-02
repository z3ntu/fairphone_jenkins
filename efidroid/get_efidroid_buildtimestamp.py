#!/usr/bin/env python2
#
# Copyright (C) 2016 The EFIDroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Heavily shrunk-down version of "dump_efidroid_metadata" from:
# https://github.com/efidroid/build/blob/master/tools/dump_efidroid_metadata

# common imports
import os
import struct
import subprocess
import sys
import time


def ROUNDUP(number, alignment):
    return (number + (alignment - 1)) & ~(alignment - 1)


def main(argv):
    # check arguments
    if not len(argv) == 1:
        raise Exception('Invalid number of arguments')
    filename = argv[0]

    # open file
    f = open(filename, 'rb')

    # read header
    fmt = '<ccccccccLLLLLLLLL'
    fmtsz = struct.calcsize(fmt)
    header = f.read(fmtsz)
    data = struct.unpack(fmt, header[0:fmtsz])
    magic = ''.join(data[0:8])

    # check magic
    if magic != 'ANDROID!':
        raise Exception('Invalid boot image')

    kernel_size = data[8]
    ramdisk_size = data[10]
    second_size = data[12]
    page_size = data[15]
    dt_size = data[16]

    # calculate offsets
    off_kernel = page_size
    off_ramdisk = off_kernel + ROUNDUP(kernel_size, page_size)
    off_second = off_ramdisk + ROUNDUP(ramdisk_size, page_size)
    off_tags = off_second + ROUNDUP(second_size, page_size)
    off_meta = off_tags + dt_size

    # read EFIDroid header
    f.seek(off_meta)
    fmt = '<ccccccccLLLLLLLL'
    fmtsz = struct.calcsize(fmt)
    header = f.read(fmtsz)
    data = struct.unpack(fmt, header[0:fmtsz])
    magic = ''.join(data[0:8])

    # check magic
    if magic != 'EFIDroid':
        raise Exception('Invalid metadata')

    # parse data
    timestamp = data[9]

    print(timestamp)

    f.close()


if __name__ == '__main__':
    main(sys.argv[1:])
