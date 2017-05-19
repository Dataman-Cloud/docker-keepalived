docker run -d \
    --name=dataman-keepalived \
    --privileged=true \
    --net=host \
    --restart always \
    -e NODE1="10.3.10.33" \
    -e NODE2="10.3.10.48" \
    -e MYSQL_ADMIN_USER="root" \
    -e MYSQL_ADMIN_PASSWORD="dataman1234" \
    -e MYSQL_USER="omega" \
    -e MYSQL_PASSWORD="omega1234" \
    -e MYSQL_DATABASE="omega-server" \
    -e CONFIG_SERVER="http://10.3.10.33" \
    -e GRETAP_IP1="10.1.1.6" \
    -e GRETAP_IP2="10.1.1.7" \
    -e BITMASK="24" \
    -v /sbin/modprobe:/sbin/modprobe \
    -v /lib/modules:/lib/modules \
shurenyun/centos7-keepalived-1.2.13-check
    #--entrypoint=/bin/bash \
