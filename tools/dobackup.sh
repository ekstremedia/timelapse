cd $HOME/backup

DT=`/bin/date +%Y%m%d`

# MySQL database
FNAME=$USER-daily-mysqlbackup-$DT.sql.bz2
/usr/bin/mysqldump --lock-tables=false -h localhost -u mq_gullkorn -pucwtbeqDMpmq7bRD mq_gullkorn | bzip2 -c >$FNAME


# Scripts, configuration files, etc.
FNAME=$USER-daily-scripts-$DT.tar.bz2
tar cfj $FNAME $HOME/eggdrop/gullkorn/etc $HOME/eggdrop/gullkorn/gullkorn $HOME/eggdrop/gullkorn/var $HOME/eggdrop/select/etc $HOME/eggdrop/select/select $HOME/eggdrop/select/var $HOME/web/*


# Delete old backups
find . -name "$USER-daily-*.bz2" -mtime +7 | xargs rm -f


# Done


