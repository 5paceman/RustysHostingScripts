#!/bin/sh
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/PauseAccount.log 2>&1
fi

SERVICEID=$1
echo "Removing from serverlist"
if grep -q $SERVICEID "/usr/local/bin/ServerList.txt"; then
  sed "/^$SERVICEID/ d" /usr/local/bin/ServerList.txt
fi
echo "Disabling service"
systemctl disable $SERVICEID
systemctl stop $SERVICEID
echo "Adding to FTP block list"
sed -i -e '$a\' -e "$SERVICEID" /etc/vsftpd.userlist
