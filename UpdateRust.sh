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
echo "Updating with SteamCMD"
/usr/games/steamcmd +login anonymous +force_install_dir "/home/$SERVICEID/rust/"  +app_update 258550 +quit
echo "Starting service"
systemctl start $SERVICEID
