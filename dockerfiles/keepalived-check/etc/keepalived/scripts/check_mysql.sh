#!/bin/bash
 
MYSQL=/usr/bin/mysql
MYSQL_HOST=${MYSQL_HOST:-"127.0.0.1"}
MYSQL_USER=${MYSQL_USER:-"zabbix_check"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"zabbix1234"}
CHECK_TIME=5
MYSQL_BIN="$MYSQL -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD"
#mysql  is working MYSQL_OK is 1 , mysql down MYSQL_OK is 0

MYSQL_OK=1

function check_mysql_helth (){
$MYSQL -h $MYSQL_HOST -u $MYSQL_USER -p$MYSQL_PASSWORD -e "show status;" >/dev/null 2>&1
if [ $? = 0 ] ;then
     MYSQL_OK=1
else
     MYSQL_OK=0
fi
     return $MYSQL_OK
}

while [ $CHECK_TIME -ne 0 ];do
     let "CHECK_TIME -= 1"
     check_mysql_helth
     if [ $MYSQL_OK = 1 ] ; then
         CHECK_TIME=0
	 /etc/keepalived/scripts/check_mysql_sync.sh
	 exit 0
     else
         if [ $MYSQL_OK -eq 0 ] &&  [ $CHECK_TIME -eq 0 ];then
	   echo "ERROR: mysql is error."
           pkill keepalived
           exit 1
         fi
     fi

     sleep 1
done 

