#!/bin/bash
vip=`awk '/dev.*label*/{print $1" "$2" "$3" "$4" "$5}' /etc/keepalived/keepalived.conf`
if [ "$vip" ];then
    echo "INFO: del $vip"
    ip addr del $vip
fi

echo "$(date "+%y%m%d-%H%M") to backup" >> /var/log/keepalived-status.log

