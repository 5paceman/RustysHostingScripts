#!/bin/bash
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/DeleteAccount.log 2>&1
fi

SERVICEID=$1
PORT=$2
echo "Removing from serverlist"
if grep -q $SERVICEID "/usr/local/bin/ServerList.txt"; then
  sed "/^$SERVICEID/ d" /usr/local/bin/ServerList.txt
fi
echo "Disabling service"
systemctl disable $SERVICEID
echo "Adding to FTP block list"
if ! grep -q $SERVICEID "/etc/vsftpd.userlist"; then
  sed -i -e '$a\' -e "$SERVICEID" /etc/vsftpd.userlist
fi
echo "Removing user.."
./RemoveUser.sh $SERVICEID $PORT
echo "Complete"
