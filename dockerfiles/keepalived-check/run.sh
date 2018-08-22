docker run -d \
    --name=dataman-keepalived \
    --privileged=true \
    --net=host \
    --restart always \
    -e NODE_LIST="10.11.20.119,10.11.20.118" \
    -e CHECK_SERVICE="haproxy" \
    -e ETH="eth0" \
    -e KEEPALIVED_VIP="10.11.20.254" \
    -v /sbin/modprobe:/sbin/modprobe \
    shurenyun/centos7-keepalived-1.3.5-check
    #-v /lib/modules:/lib/modules \
    #-e BITMASK="24" \
    #--entrypoint=/bin/bash \
