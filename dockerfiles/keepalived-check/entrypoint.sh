#!/bin/bash
#set -ex

if [ "x$CONFIG_SERVER" != "x" ];then
    export DM_READ_URI=`curl $CONFIG_SERVER/config/$(hostname)/keepalived/filelist.json`
fi

if [ "x$DM_READ_URI" != "x" ];then
	/DM_DOCKER_URI.py
fi

ETH=${ETH:-"eth0"}
BITMASK=${BITMASK:-"24"}
export LOCAL_IP=`ip a show $ETH|awk '/inet.*brd.*'$ETH'/{print $2}'|awk -F "/" '{print $1}'`


if [ -z $NODE1 ] || [ -z $NODE2 ] || [ -z $LOCAL_IP ];then
    echo "LOCAL_IP or NODE1 or NODE2 is empty"
elif [ "$LOCAL_IP" == "$NODE1" ];then
    export REMOTE_IP=$NODE2
    GRETAP_IP=$GRETAP_IP1
elif [ "$LOCAL_IP" == "$NODE2" ];then
    export REMOTE_IP=$NODE1
    GRETAP_IP=$GRETAP_IP2
else
    echo "ERROR: Local_ip and node IP does not match." && exit 1
fi

if  ! ip addr show gretap1 &>/dev/null ;then
    ip link add gretap1 type gretap local $LOCAL_IP remote $REMOTE_IP
    ip link set dev gretap1 up
    ip addr add dev gretap1 $GRETAP_IP/$BITMASK
fi



#trap "pkill keepalived ; exit 1" SIGHUP SIGINT SIGTERM EXIT

#echo '' > /var/log/keepalived-status.log
/etc/keepalived/build_config.sh && \
/usr/sbin/keepalived --dont-fork --log-console
