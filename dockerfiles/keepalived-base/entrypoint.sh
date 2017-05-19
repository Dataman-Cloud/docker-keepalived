#!/bin/bash
set -x

if [ "x$CONFIG_SERVER" != "x" ];then
    export DM_READ_URI=`curl $CONFIG_SERVER/config/$(hostname)/keepalived/filelist.json`
fi

if [ "x$DM_READ_URI" != "x" ];then
	/DM_DOCKER_URI.py
fi

/init_network.sh && \
/usr/sbin/keepalived --dont-fork --log-console
