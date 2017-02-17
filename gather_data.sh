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

PROXMARK="../rfidbumping/client/proxmark3 /dev/ttyACM0"
#PROXMARK="cat"
oldkey="FFFFFFFFFFFF"
BLOCK=7
KEYTYPE="A"
TOTALKEYS=0

# HW TUNE
#echo 'hw tune' | $PROXMARK

function genNum() {
	RANGE=255

	number=$RANDOM
	let "number %= $RANGE"
        number=`echo "obase=16;$number" | bc`

 	number2=$RANDOM
	let "number2 %= $RANGE"
        number2=`echo "obase=16;$number2" | bc`

	number3=$RANDOM
	let "number3 %= $RANGE"
        number3=`echo "obase=16;$number3" | bc`

	number4=$RANDOM
	let "number4 %= $RANGE"
        number4=`echo "obase=16;$number4" | bc`

	number5=$RANDOM
	let "number5 %= $RANGE"
        number5=`echo "obase=16;$number5" | bc`

	number6=$RANDOM
	let "number6 %= $RANGE"
        number6=`echo "obase=16;$number6" | bc`
 	[[ ${#number} < 2 ]] && number="0$number"
 	[[ ${#number2} < 2 ]] && number2="0$number2"
 	[[ ${#number3} < 2 ]] && number3="0$number3"
 	[[ ${#number4} < 2 ]] && number4="0$number4"
 	[[ ${#number5} < 2 ]] && number5="0$number5"
 	[[ ${#number6} < 2 ]] && number6="0$number6"
	key="$number$number2$number3$number4$number5$number6"
}

for RUN in {0..99}
do
	echo "----BEGIN----"
	echo "Starting run $RUN"

	echo -n "WRITE_KEY:" >> output.log
	for CKEY in $(seq 0 $TOTALKEYS);
	do
		genNum
		cblock=$(expr 4 \* $CKEY + $BLOCK)
		coldkey=oldkey_${cblock}
		echo "Writing key $KEYTYPE ${key} to block $cblock"
		echo "hf mf wrbl $cblock A FFFFFFFFFFFF ${key}ff078069ffffffffffff" | $PROXMARK
		declare oldkey_${cblock}="$key"
		echo -n "${cblock} A ${key}|" >> output.log
	done
	oldkey=$key
	
	echo "" >>output.log
	echo "Attacking cards"
	echo "bump attack" | $PROXMARK >> output.log 2>&1
	echo "Attacking done"
	echo "Creating archive and cleaning up"
	
	# If directory is not there, create it
	[ -d ./archive-$RUN/ ] || mkdir ./archive-$RUN/
	[ -d ./archive-$RUN/nonces/ ] || mkdir ./archive-$RUN/nonces/
	[ -f ./cards.db ] && mv cards.db ./archive-$RUN/
	mv *.bin ./archive-$RUN/nonces/ >/dev/null 2>&1
	mv *.log ./archive-$RUN/ >/dev/null 2>&1
	
	for CKEY in $(seq 0 $TOTALKEYS);
	do
		cblock=$(expr 4 \* $CKEY + $BLOCK)
		key="FFFFFFFFFFFF"
	        coldkey=oldkey_${cblock}
		echo "Resetting $cblock to $key"
        	echo "hf mf wrbl $cblock A ${!coldkey} ${key}ff078069ffffffffffff" | $PROXMARK
	done
	echo "Done run $RUN, sleeping for 3 sec"
	echo "----END----"
	echo ""
	sleep 3
done

echo "Done"
