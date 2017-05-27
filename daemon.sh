#!/bin/bash

function check_process()
{
    process_num=`ps -e | grep "$1" | grep -v "grep" | wc -l`
    if [ $process_num -ge 1 ];
    then
        return 0
    else
        return 1
    fi
}

if [ "$1" = "" ];
then
    echo "please input ./xxx"
    exit
fi

while [ 1 ] ; do
    process_name=`basename $1`
    check_process $process_name 
    check_ret=$?
    if [ $check_ret -eq 1 ];
    then
        now=`date +%Y-%m-%d_%H:%M:%S`
        echo "$now restart $process_name $@"
        killall -9 $process_name
        exec nohup $@ &
    fi
    sleep 1
done

