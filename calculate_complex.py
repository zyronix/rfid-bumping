#!/usr/bin/python

# Copyright (c) 2016, Romke van Dijk & Loek Sangers
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import os
import subprocess
import math

CRAPTEV = "./craptev1"
LEFT = os.path.join(CRAPTEV, "left")
DATASETS = "./datasets/"

def runCmd(cmd):
    p = subprocess.Popen(cmd,shell = True, stdin=subprocess.PIPE,stdout = subprocess.PIPE, stderr = subprocess.STDOUT)
    s1 = p.stdout.read()
    s2 = s1.decode()
    return s2
print "file;complex_int;complex_log;nonces;"

archive_dir = {}

for root, dirs, files in os.walk(DATASETS):
    archive_tmp = root.split("/")
    if len(archive_tmp) > 2:
        archive_dir[archive_tmp[2]] = {}
        archive_dir[archive_tmp[2]]["compl"] = []
        archive_dir[archive_tmp[2]]["log"] = []
        archive_dir[archive_tmp[2]]["nonces"] = []

for root, dirs, files in os.walk(DATASETS):
    for f in files:
        if len(root.split("/")) > 2:
            archive = root.split("/")[2]
        compl = 0
        log = 0
        if f.endswith(".bin"):
            compl = runCmd("%s -f %s -u %s" % (LEFT, os.path.join(root, f), f[:8]))
            compl = compl.split(":")
            compl = compl[1]
            compl = int(compl, 16)
            archive_dir[archive]["compl"].append(str(compl))
            log = math.log(compl, 2)
            archive_dir[archive]["log"].append(str(log))
        if f == "output.log":
            f_p = open(os.path.join(root, f), 'r')
            nonces_list = []
            for line in f_p:
                #print line
                if "Acquired a total of" in line:
                    nonces = line.split(" ")
                    nonces = nonces[4]
                    archive_dir[archive]["nonces"].append(str(nonces))
            
            f_p.close()

for k in archive_dir.keys():
    line = "%s;%s;%s;%s;" % (k ,"|".join(archive_dir[k]['compl']), "|".join(archive_dir[k]['log']), "|".join(archive_dir[k]['nonces']))
    print line
