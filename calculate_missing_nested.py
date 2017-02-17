#!/usr/bin/python2

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

import sqlite3
import os

DATASETS = "./datasets/"

def getData(dbfile):
    conn = sqlite3.connect(dbfile)
    
    c = conn.cursor()
    
    # Create table
    for result in c.execute("SELECT COUNT(*) FROM keys WHERE keyA IS NOT 'ffffffffffff' AND keyA IS NOT 'a0a1a2a3a4a5'"):
        changed_keys = float(result[0])
    
    for result in c.execute("SELECT COUNT(keyA) FROM keys WHERE keyA IS NOT 'ffffffffffff' AND keyA IS NOT 'a0a1a2a3a4a5'"):
        got_keys = float(result[0])
    
    conn.commit()
    conn.close()
    return (changed_keys, got_keys)

g_changed_keys = 0.0
g_got_keys = 0.0

print "file;changed_keys;got_keys;"
for root, dirs, files in os.walk(DATASETS):
    for f in files:
        if f == 'cards.db':
            a, b = getData(os.path.join(root, f))
            print "%s;%f;%f;" % (root.split("/")[-1], a, b)
            g_changed_keys += a
            g_got_keys += b

print "#Rate: %f" % (g_got_keys/g_changed_keys)
