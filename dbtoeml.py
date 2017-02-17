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
import sys


def getData(uid, db):
    conn = sqlite3.connect(db)
    
    c = conn.cursor()
    i = 0
    # Create table
    for result in c.execute("SELECT data FROM keys WHERE UID='%s'" % uid.lower()):
	if(i < 32):
		print result[0][0:32]
		print result[0][32:64]
		print result[0][64:96]
		print result[0][96:128]
	else:
		print result[0][0:32]
		print result[0][32:64]
		print result[0][64:96]
		print result[0][96:128]
		print result[0][128:160]
		print result[0][160:192]
		print result[0][192:224]
		print result[0][224:256]
		print result[0][256:288]
		print result[0][288:320]
		print result[0][320:352]
		print result[0][352:384]
		print result[0][384:416]
		print result[0][416:448]
		print result[0][448:480]
		print result[0][480:512]
	i += 1
        
    conn.commit()
    conn.close()
    return

getData(sys.argv[1], sys.argv[2])
