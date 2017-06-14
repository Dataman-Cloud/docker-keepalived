docker run -d \
    --name=dataman-keepalived \
    --privileged=true \
    --net=host \
    --restart always \
    -e NODE_LIST="10.3.10.33,10.3.10.34,10.3.10.35"
    -e CHECK_SERVICE="haproxy" \
    -e ETH="eth0" \
    -e KEEPALIVED_VIP="10.3.10.254" \
    -e BITMASK="24" \
    -v /sbin/modprobe:/sbin/modprobe \
    -v /lib/modules:/lib/modules \
    shurenyun/centos7-keepalived-1.3.5-check
    #--entrypoint=/bin/bash \
