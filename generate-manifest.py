#!/usr/bin/python

from datetime import datetime
import hashlib
import json
import os

url_base = "https://raw.githubusercontent.com/z3ntu/multirom_fairphone_fp2/master/"

mr_filename = "multirom-20160716-v33-UNOFFICIAL-FP2.zip"
mr_version = "33"
rec_filename = "TWRP_3.0.0-0_multirom_FP2_20160716-02.img"
rec_version = "mrom20160716-02"
uninstaller = "multirom_uninstaller.zip"

manifest = {}

manifest['status'] = "ok"
manifest['date'] = datetime.today().strftime('%Y-%m-%d')
manifest['commands'] = ""
manifest['gpg'] = False
manifest['devices'] = []
devices = []
files = []
files.append({"url": url_base + "installer/" + mr_filename, "version": mr_version, "size": os.path.getsize(mr_filename), "md5": hashlib.md5(open(mr_filename, "rb").read()).hexdigest()})
files.append({"url": url_base + "recovery/" + rec_filename, "version": rec_version, "size": os.path.getsize(rec_filename), "md5": hashlib.md5(open(rec_filename, "rb").read()).hexdigest()})
files.append({"url": url_base + "uninstaller/multirom_uninstaller.zip", "version": "", "size": os.path.getsize(uninstaller), "md5": hashlib.md5(open(uninstaller, "rb").read()).hexdigest()})
ubuntu_touch = {"req_multirom": "33", "req_recovery": "mrom20160716-01"}
devices.append({"name": "FP2", "files": files, "ubuntu_touch": ubuntu_touch})

manifest['devices'] = devices

output = json.dumps(manifest)
print(output)
