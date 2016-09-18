#!/usr/bin/python

from datetime import datetime
import hashlib
import json
import os
import sys

url_base = "https://raw.githubusercontent.com/z3ntu/multirom_fairphone_fp2/master/"

mr_filename = sys.argv[1]
rec_filename = sys.argv[2]
#kernel_filename = sys.argv[3]
uninstaller = "/home/jenkins/multirom_fairphone_fp2/uninstaller/multirom_uninstaller.zip"

mr_version = mr_filename.split("-")[2].replace("v", "")
rec_version = "mrom" + rec_filename.split("_")[4].split(".")[0]
#k_parts = kernel_filename.split("-")
#kernel_version = "kexec-hardboot " + k_parts[4] + "-" + k_parts[5] + "-" + k_parts[6].split(".")[0] + "_" + k_parts[3]

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
#files.append({"url": url_base + "kernel/" + os.path.basename(kernel_filename), "version": kernel_version, "size": os.path.getsize(kernel_filename), "md5": hashlib.md5(open(kernel_filename, "rb").read()).hexdigest(), "type": "kernel"})
files.append({"url": url_base + "uninstaller/multirom_uninstaller.zip", "version": "", "size": os.path.getsize(uninstaller), "md5": hashlib.md5(open(uninstaller, "rb").read()).hexdigest(), "type": "uninstaller"})

ubuntu_touch = {"req_multirom": "33", "req_recovery": "mrom20160716-01"}

devices.append({"name": "FP2", "files": files, "ubuntu_touch": ubuntu_touch})

manifest['devices'] = devices

output = json.dumps(manifest, sort_keys=True)
print(output)
