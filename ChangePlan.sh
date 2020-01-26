#!/bin/bash
ORIGINALPLAN=$1
NEWPLAN=$2
INSTANCEID=$3
echo "Removing user from old group."
deluser $INSTANCEID $ORIGINALPLAN
echo "Adding user to new group."
usermod -a -G $NEWPLAN $INSTANCEID
echo "Complete."
