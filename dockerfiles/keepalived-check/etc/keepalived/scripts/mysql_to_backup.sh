#!/bin/bash

errorcode=0
if [ -z "$MYSQL_ADMIN_USER" ] || [ -z "$MYSQL_ADMIN_PASSWORD" ] ;then
        echo "ERROR: ENV  MYSQL_ADMIN_USER or MYSQL_ADMIN_PASSWORD is Null."
        let errorcode=$errorcode+1
fi

if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] ;then
        echo "INFO: ENV  MYSQL_USER or MYSQL_PASSWORD is Null."
	#let errorcode=$errorcode+1
fi

if [ -z "$NODE1" ] || [ -z "$NODE2" ];then
	echo "ERROR: ENV NODE1 and NODE2 is Null."
	let errorcode=$errorcode+1
fi


vip=`awk '/dev.*label*/{print $1" "$2" "$3" "$4" "$5}' /etc/keepalived/keepalived.conf`
if [ "$vip" ];then
    echo "INFO: del $vip"
    ip addr del $vip
fi


MYSQL=/usr/bin/mysql
MYSQL_HOST=127.0.0.1
MYSQL_BIN="$MYSQL -h$MYSQL_HOST -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PASSWORD"
#LOCAL_IP=`hostname|awk -F. '{print $2}'|sed 's/-/./g'`
ETH=${ETH:-"eth0"} 
LOCAL_IP=`ip a show $ETH|awk '/inet.*brd.*'$ETH'/{print $2}'|awk -F "/" '{print $1}'`


if [ "$NODE1" == "$LOCAL_IP" ];then
        MASTER_HOST=$NODE2
elif [ "$NODE2" == "$LOCAL_IP" ];then
        MASTER_HOST=$NODE1
else
        echo "ERROR: MASTER_HOST ERROR!" && let errorcode=$errorcode+1
fi

if [ $errorcode -ne 0 ];then
        pkill keepalived
	exit 1
fi

sql=""
if [ ! -z "$MYSQL_USER" ] && [ "$MYSQL_USER" != "root" ];then
    sql+="
        GRANT select,show view ON \`"$MYSQL_DATABASE"\`.* TO '"$MYSQL_USER"'@'%' IDENTIFIED BY '"$MYSQL_PASSWORD"';FLUSH PRIVILEGES ;
        REVOKE ALL ON \`"$MYSQL_DATABASE"\`.* FROM '"$MYSQL_USER"'@'%' ;FLUSH PRIVILEGES ;
        GRANT select,show view ON \`"$MYSQL_DATABASE"\`.* TO '"$MYSQL_USER"'@'%' IDENTIFIED BY '"$MYSQL_PASSWORD"';FLUSH PRIVILEGES ;
    "
fi

sql+="
stop slave;
change master to MASTER_HOST='"$MASTER_HOST"',master_user='"$MYSQL_ADMIN_USER"',master_password='"$MYSQL_ADMIN_PASSWORD"',MASTER_PORT = 3306,MASTER_CONNECT_RETRY = 60,master_auto_position=1;
start slave;
"
$MYSQL_BIN -e "$sql"

/etc/keepalived/scripts/to_backup.sh
date +%s > /var/log/mysql-to-backup-time
