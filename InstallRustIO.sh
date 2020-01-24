DEBUG=false
if [ "$DEBUG" = false ] ; then
    exec 3>&1 4>&2
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>/var/log/InstallRustIO.log 2>&1
fi

cd $1/RustDedicated_Data/Managed
wget -O Oxide.Ext.RustIO.dll http://playrust.io/latest
