#!/bin/bash
count=0
for (( k=0; k<2; k++ )) 
do 
    check_code=$( curl --connect-timeout 3 -sL -w "%{http_code}\\n" --user dataman:dataman "http://127.0.0.1:9000/;csv" -o /dev/null )
    if [ "$check_code" != "200" ]; then
        count=count+1
        continue
    else
        count=0
        break
    fi
done
if [ "$count" != "0" ]; then
    pkill keepalived
    exit 1
else
    exit 0
fi
