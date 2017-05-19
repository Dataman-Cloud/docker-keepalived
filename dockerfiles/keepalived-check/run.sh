docker run -d \
    --name=dataman-keepalived \
    --privileged=true \
    --net=host \
    --restart always \
    -e NODE1="10.3.10.33" \
    -e NODE2="10.3.10.48" \
    -e GRETAP_IP1="10.1.1.2" \
    -e GRETAP_IP2="10.1.1.3" \
    -e CHECK_SERVICE="haproxy" \
    -e ETH="eth0" \
    -e KEEPALIVED_VIP="10.3.10.254" \
    -e BITMASK="24"
    -v /sbin/modprobe:/sbin/modprobe \
    -v /lib/modules:/lib/modules \
    shurenyun/centos7-keepalived-1.2.13-check
    #--entrypoint=/bin/bash \
