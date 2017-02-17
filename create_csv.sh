#!/bin/bash

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

rm archive-*/proxmark3.log
echo "file;keys;type;start;activate_start;active_stop;default_start;default_stop;nested_start;nested_stop;hard_start;hard_stop;data_start;data_stop;stop"
function getData {
LOG=$1
start=$(grep 'TIME_START_attackMifareClassic' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)
stop=$(grep 'TIME_TIME_STOP_getCardData' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)

keys=$(grep 'WRITE_KEY' "${LOG}" | cut -d ':' -f2 )

activate_start=$(grep 'TIME_START_activateCard' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)
active_stop=$(grep 'TIME_STOP_activateCard' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)

default_start=$(grep 'TIME_START_checkDefaultKeys' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)
default_stop=$(grep 'TIME_STOP_checkDefaultKeys' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)

nested_start=$(grep 'TIME_START_performNestedAttack' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)
nested_stop=$(grep 'TIME_STOP_performNestedAttack' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)

hard_start=$(grep 'TIME_START_bumpnestedhard' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)
hard_stop=$(grep 'TIME_STOP_bumpnestedhard' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)

data_start=$(grep 'TIME_START_getCardData' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)
data_stop=$(grep 'TIME_STOP_getCardData' "${LOG}" | cut -d ':' -f2 | cut -d ' ' -f2)

echo "$LOG;$keys;$type;$start;$activate_start;$active_stop;$default_start;$default_stop;$nested_start;$nested_stop;$hard_start;$hard_stop;$data_start;$data_stop;$stop"
}

for i in */*.log
do
	if [ -f $i ]
	then
		getData $i
	fi
done
