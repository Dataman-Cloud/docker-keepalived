#!/bin/bash
set -e
#set -x

if [ "x$CONFIG_SERVER" != "x" ];then
    export DM_READ_URI=`curl $CONFIG_SERVER/config/$(hostname)/keepalived/filelist.json`
fi

if [ "x$DM_READ_URI" != "x" ];then
	/DM_DOCKER_URI.py
fi

error(){
	info=$1
	errorcode=${2:-"1"}
	echo $info && exit $errorcode
}

is_empty(){
	name=$1
	valuie=$2
	if [ -z "$valuie" ];then
		error "$name is empty !"
	fi
}

export ETH=${ETH:-"eth0"}
export BITMASK=${BITMASK:-"24"}
export LOCAL_IP=`ip a show $ETH|awk '/inet.*brd.*'$ETH'/{print $2}'|awk -F "/" '{print $1}'`

# Determine whether is empty
is_empty LOCAL_IP $LOCAL_IP
is_empty KEEPALIVED_VIP $KEEPALIVED_VIP
is_empty NODE_LIST $NODE_LIST
is_empty CHECK_SERVICE $CHECK_SERVICE


# build config
./etc/keepalived/build_config.sh

# run
CMD="/usr/sbin/keepalived --dont-fork --log-console"
exec $CMD
