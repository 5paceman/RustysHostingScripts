#!/bin/bash
# Script to remove a user and cleanup hosting space
#
# SYNTAX: RemoveUser.sh instanceid
#
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/RemoveUser.log 2>&1
fi

INSTANCEID=$1
BASEPORT=$2

echo "========= RemoveUser.sh =========="
echo "InstanceID is $INSTANCEID"
echo "Killing all processes.."
USERID=$(id -u $INSTANCEID)
pkill -U $USERID
echo "Removing firewall rule.."
ufw delete allow $BASEPORT
ufw delete $(($BASEPORT + 1))
ufw delete $(($BASEPORT + 2))
echo "Removing user.."
userdel $INSTANCEID
echo "Removing user files.."
rm -R -d /home/$INSTANCEID
rm /etc/systemd/system/$INSTANCEID.service
sed -i "/^$INSTANCEID/ d" ServerList.txt
echo "========== END =========="

