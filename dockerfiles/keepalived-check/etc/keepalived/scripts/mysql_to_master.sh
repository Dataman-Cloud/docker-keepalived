#!/bin/bash

errorcode=0
if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] ;then
        echo "ERROR: ENV MYSQL_DATABASE or MYSQL_USER or MYSQL_PASSWORD is Null." && errorcode=$errorcode+1
fi

if [ -z "$MYSQL_ADMIN_USER" ] || [ -z "$MYSQL_ADMIN_PASSWORD" ];then
	echo "ERROR: ENV MYSQL_ADMIN_USER or MYSQL_ADMIN_PASSWORD is Null." && errorcode=$errorcode+1
fi

if [ $errorcode -ne 0 ];then
    pkill keepalived
    exit 1
fi

MYSQL=/usr/bin/mysql
MYSQL_HOST=127.0.0.1
MYSQL_BIN="$MYSQL -h$MYSQL_HOST -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PASSWORD"

sql="
GRANT ALL ON \`"$MYSQL_DATABASE"\`.* TO '"$MYSQL_USER"'@'%' IDENTIFIED BY '"$MYSQL_PASSWORD"';
FLUSH PRIVILEGES ;
"
#stop slave;
$MYSQL_BIN -e "$sql"

/etc/keepalived/scripts/to_master.sh
