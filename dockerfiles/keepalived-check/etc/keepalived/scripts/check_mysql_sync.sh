#!/bin/bash
MYSQL=/usr/bin/mysql
MYSQL_HOST=127.0.0.1
MYSQL_BIN="$MYSQL -h$MYSQL_HOST -u$MYSQL_ADMIN_USER -p$MYSQL_ADMIN_PASSWORD"

timefile="/var/log/mysql-to-backup-time"
if [ -f "$timefile" ]; then

    num=`cat $timefile`
    now_num=`date +%s`
    let value=$now_num-$num

    if [ $value -gt 60  ];then
	 sql="show slave status \G"
	 slave_status_run_num=`$MYSQL_BIN -e "$sql" | grep -E 'Slave_IO_Running:|Slave_SQL_Running:'|grep -i "Yes"|wc -l`
         tail -1 /var/log/keepalived-status.log|grep 'backup'
         if [ $? -eq 0 ] && [ $slave_status_run_num -ne 2 ] ;then
            echo "ERROR: slave sync error." &&  pkill keepalived
            exit 1
         fi
         exit 0
    fi
else
	date +%s > $timefile
fi
