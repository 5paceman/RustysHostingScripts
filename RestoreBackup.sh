#!/bin/bash
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/RestoreBackup.log 2>&1
fi

INSTANCEID=$1
BACKUP_FILE=$2
SPACE=$3
echo "Stopping service"
systemctl stop $INSTANCEID
echo "Downloading backup"
s3cmd get s3://$SPACE/$BACKUP_FILE /usr/local/bin/backups/restore/$BACKUP_FILE
echo "Extracting files"
tar -C / -zxvf /usr/local/bin/backups/restore/$BACKUP_FILE
echo "Removing temp files"
rm /usr/local/bin/backups/restore/$BACKUP_FILE
echo "Restarting service"
systemctl start $INSTANCEID
echo "Finished."
