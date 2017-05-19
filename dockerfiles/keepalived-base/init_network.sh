#!/bin/bash
#LOCAL_IP=`hostname|awk -F. '{print $2}'|sed 's/-/./g'`
ETH=${ETH:-"eth0"}
BITMASK=${BITMASK:-"24"}
export LOCAL_IP=`ip a show $ETH|awk '/inet.*brd.*'$ETH'/{print $2}'|awk -F "/" '{print $1}'`

if  ! ip addr show gretap1 &>/dev/null ;then
    if [ -z $NODE1 ] || [ -z $NODE2 ] || [ -z $LOCAL_IP ];then
	echo "LOCAL_IP or NODE1 or NODE2 is empty"
    elif [ "$LOCAL_IP" == "$NODE1" ];then
	export REMOTE_NODE=$NODE2
        ip link add gretap1 type gretap local $NODE1 remote $NODE2
        ip link set dev gretap1 up
        ip addr add dev gretap1 $GRETAP_IP1/$BITMASK
    elif [ "$LOCAL_IP" == "$NODE2" ];then
	export REMOTE_NODE=$NODE1
        ip link add gretap1 type gretap local $NODE2 remote $NODE1
        ip link set dev gretap1 up
        ip addr add dev gretap1 $GRETAP_IP2/$BITMASK
    else
	echo "ERROR: Local_ip and node IP does not match." && exit 1
    fi
fi
