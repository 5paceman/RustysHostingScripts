#!/bin/bash
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/RemoveBackup.log 2>&1
fi

SPACE=$1
FILE=$2
echo "Deleting backup $FILE"
s3cmd del s3://$SPACE/$FILE
echo "Finished."
