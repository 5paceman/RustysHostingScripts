#!/bin/bash
DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/UpdateRust.log 2>&1
fi

SERVICEID=$1
echo "Stopping service"
systemctl stop $SERVICEID
cd "/home/$SERVICEID/rust/"
echo "Downloading oxide"
wget https://umod.org/games/rust/download/develop
unzip -o develop
echo "Mounting oxide folder"
mkdir "/home/$SERVICEID/rust/oxide"
mkdir "/home/$SERVICEID/rust/server/identity/oxide"
mount --bind "/home/$SERVICEID/rust/oxide" "/home/$SERVICEID/rust/server/identity/oxide"
echo "Starting service"
systemctl start $SERVICEID