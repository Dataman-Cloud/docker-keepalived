#!/bin/bash
vip=`awk '/dev.*label*/{print $1}' /etc/keepalived/keepalived.conf|awk -F/ '{print $1}'`

tail -1 /var/log/keepalived-status.log | grep master || exit 0

ip a | grep $vip >/dev/null 2>&1
if [  $? -ne 0 ];then
        pkill keepalived
        exit $status
fi
