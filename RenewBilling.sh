#!/bin/sh
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/RenewBilling.log 2>&1
fi

SERVICEID=$1
echo "Adding back to Server list"
if ! grep -q $SERVICEID "/usr/local/bin/ServerList.txt"; then
  sed -i -e '$a\' -e "$SERVICEID" /usr/local/bin/ServerList.txt
fi
echo "Removing from FTP block list"
if grep -q $SERVICEID "/etc/vsftpd.userlist"; then
   sed "/^$SERVICEID/ d" /etc/vsftpd.userlist
fi
echo "Enabling service"
systemctl enable $SERVICEID



