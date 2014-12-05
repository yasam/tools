#!/bin/sh

if [ $# != 2 ];then
	echo "usage: ipscan.sh from_ip to_ip"
	exit 1;
fi

FROM=$1
TO=$2

BASE=`echo $FROM | cut -d '.' -f1,2,3`
START=`echo $FROM | cut -d '.' -f4`
END=`echo $TO | cut -d '.' -f4`

IDX=$START
CNT=0

echo pinging from  $BASE.$START to $BASE.$END
for (( IDX=$START; IDX <= $END; IDX++ ))
do
    IP=$BASE.$IDX
    ping $IP -c 1 -W 1 > /dev/null
    
    if [ $? == 0 ]; then
	echo $IP foound.
	CNT=$((CNT+1))
    fi

done

echo $CNT found.

exit 0
