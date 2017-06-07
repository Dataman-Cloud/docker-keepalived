#!/bin/bash
echo "$(date "+%y%m%d-%H%M") to master" >> /var/log/keepalived-status.log

GATEWAY=`ip route show|grep default|awk '{print $3}'`
if [ -z "$GATEWAY" ];then
	GATEWAY="0.0.0.0"
fi

arping -I $ETH -c 3 -s $KEEPALIVED_VIP $GATEWAY
