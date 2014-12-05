#!/bin/sh

if [ $# != 2 ];then
	echo "usage: ipscan.sh from_ip to_ip"
	exit 1;
fi

FROM=$1
TO=$2

dec2ip () {
    local ip dec=$@
    for e in {3..0}
    do
        ((octet = dec / (256 ** e) ))
        ((dec -= octet * 256 ** e))
        ip+=$delim$octet
        delim=.
    done
    echo $ip
}


ip2dec () {
    local a b c d ip=$@
    IFS=. read -r a b c d <<< "$ip"
    dec=$((a * 256 ** 3 + b * 256 ** 2 + c * 256 + d))
    echo $dec
}

START=`ip2dec $FROM`
END=`ip2dec $TO`


for (( IDX=$START; IDX <= $END; IDX++ ))
do
    IP=`dec2ip $IDX`
    echo -n "PINGING $IP ..."
    ping $IP -c 1 -W 1 > /dev/null
    if [ $? == 0 ]; then
	echo "FOUND"
	CNT=$((CNT+1))
    else
	echo ""
    fi

done

echo $CNT found.

exit 0
