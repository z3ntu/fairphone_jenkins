#!/usr/bin/python

from datetime import datetime
import hashlib
import json
import os
import sys

url_base = "https://raw.githubusercontent.com/z3ntu/multirom_fairphone_fp2/master/"

#mr_filename = "/home/jenkins/multirom_fairphone_fp2/installer/multirom-20160716-v33-UNOFFICIAL-FP2.zip"
#rec_filename = "/home/jenkins/multirom_fairphone_fp2/recovery/TWRP_3.0.0-0_multirom_FP2_20160716-02.img"
mr_filename = sys.argv[1]
rec_filename = sys.argv[2]
uninstaller = "/home/jenkins/multirom_fairphone_fp2/uninstaller/multirom_uninstaller.zip"

mr_version = mr_filename.split("-")[2].replace("v", "")
rec_version = "mrom" + rec_filename.split("_")[4].split(".")[0]

manifest = {}

manifest['status'] = "ok"
manifest['date'] = datetime.today().strftime('%Y-%m-%d')
manifest['commands'] = ""
manifest['gpg'] = False
manifest['devices'] = []
devices = []
files = []
files.append({"url": url_base + "installer/" + os.path.basename(mr_filename), "version": mr_version, "size": os.path.getsize(mr_filename), "md5": hashlib.md5(open(mr_filename, "rb").read()).hexdigest(), "type": "multirom"})
files.append({"url": url_base + "recovery/" + os.path.basename(rec_filename), "version": rec_version, "size": os.path.getsize(rec_filename), "md5": hashlib.md5(open(rec_filename, "rb").read()).hexdigest(), "type": "recovery"})
files.append({"url": url_base + "uninstaller/multirom_uninstaller.zip", "version": "", "size": os.path.getsize(uninstaller), "md5": hashlib.md5(open(uninstaller, "rb").read()).hexdigest(), "type": "uninstaller"})
ubuntu_touch = {"req_multirom": "33", "req_recovery": "mrom20160716-01"}
devices.append({"name": "FP2", "files": files, "ubuntu_touch": ubuntu_touch})

manifest['devices'] = devices

output = json.dumps(manifest)
print(output)
