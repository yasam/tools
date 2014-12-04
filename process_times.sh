#!/bin/bash

if [ $# != 1 ]; then
    echo "usage: ./process_times.sh time_files.txt"
    exit 1;
fi
FILE=$1


input=$FILE

declare -A TIMES

echo "========================================"
echo "MAKE TARGET DURATIONS:"
echo "========================================"
while read line 
do

    TAGSTR=`echo $line | cut -d '=' -f 1`;
    TAG=`echo $TAGSTR | cut -d '_' -f 1`;
    OP=`echo $TAGSTR | cut -d '_' -f 2`;
    VAL=`echo $line | cut -d '=' -f 2`;
    DT=`echo $line | cut -d '=' -f 3`;
    #echo $TAG:$OP=$VAL
    
    if [ "$OP" = "start" ]; then
	#echo "start detected"
	TIMES[$TAG]=$VAL
    elif [ "$OP" = "end" ]; then
	#echo "end detected"
	START=${TIMES[$TAG]}
	DIFF=$(($VAL-$START))
	MIN=$(($DIFF/60))
	SEC=$(($DIFF%60))
	#echo -e "$TAG\t: "$MIN"m"$SEC"s"
	printf "duration -%-16s:%dm%ds\n" $TAG $MIN $SEC
	#echo $TAG:$TS-$START=$(($TS-$START))
    else
	#echo "skipping $TAG-$OP"
	printf "timestamp-%-16s:%s\n" $TAGSTR $DT
    fi
done < "$input"

echo "========================================"

exit 0
