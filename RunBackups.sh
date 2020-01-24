#!/bin/bash
while IFS= read -r line
do
server=$line
./BackupInstance.sh $line
done < "$serverlist"

