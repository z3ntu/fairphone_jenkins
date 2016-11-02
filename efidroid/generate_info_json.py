#!/usr/bin/python

import os
import json
import subprocess
import time

url_base = "https://private.z3ntu.xyz/efidroid/builds/fairphone/fp2/"
out_path = "/srv/http/efidroid/builds/fairphone/fp2/"

json_file = "/srv/http/efidroid/ota/master/fairphone/fp2/info.json"

fullpath = subprocess.check_output("ls -t /srv/http/efidroid/builds/fairphone/fp2/otapackage-*-fairphone_fp2.zip | head -1", shell=True).decode("utf-8").replace("\n", "")
filename = os.path.basename(fullpath)
filepath = os.path.dirname(fullpath)

subprocess.run(["unzip", "-d", "/tmp/tmppathplsdontdelete", fullpath, "boot.img"], stdout=subprocess.PIPE)
timestamp = subprocess.check_output([os.path.dirname(os.path.realpath(__file__)) + "/get_efidroid_buildtimestamp.py", "/tmp/tmppathplsdontdelete/boot.img"])
os.remove("/tmp/tmppathplsdontdelete/boot.img")

output = [{"file": url_base + filename, "timestamp": int(time.time())}]

json_out = json.dumps(output, sort_keys=True)

f = open(json_file, "w")
f.write(json_out)
print(json_out)
