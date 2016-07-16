#!/usr/bin/python

import hashlib
import json
import os

url_base = "https://raw.githubusercontent.com/z3ntu/multirom_fairphone_fp2/master/recovery/"

mr_filename = "multirom-20160716-v33-UNOFFICIAL-FP2.zip"
mr_version = "33"
rec_filename = "TWRP_3.0.0-0_multirom_FP2_20160426-01.img"
uninstaller = "multirom_uninstaller.zip"

manifest = {}

manifest['status'] = "ok"
manifest['date'] = "2016-07-16"
manifest['devices'] = []
devices = []
files = []
files.append({"url": url_base + "multirom-something", "version": mr_version, "size": os.path.getsize(mr_filename), "md5": hashlib.md5(open(mr_filename, "rb").read()).hexdigest()})
files.append({"url": url_base + "TWRP-something", "version": rec_version, "size": os.path.getsize(rec_filename), "md5": hashlib.md5(open(rec_filename, "rb").read()).hexdigest()})
files.append({"url": url_base + "uninstaller/multirom_uninstaller.zip", "version": "", "size": os.path.getsize(uninstaller), "md5": hashlib.md5(open(uninstaller, "rb").read()).hexdigest()})
ubuntu_touch = {"req_multirom": "33", "req_recovery": "mrom20160716-01"}
devices.append({"name": "FP2", "files": files, "ubuntu_touch": ubuntu_touch})

manifest['devices'] = devices

output = json.dumps(manifest)
print(output)
