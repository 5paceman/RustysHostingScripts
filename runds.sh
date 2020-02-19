#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`dirname $0`/RustDedicated_Data/Plugins/x86_64

SERVERPORT=28015
RCONPORT=28016
RCONPASSWORD="password"
MAXPLAYERS=20
GLOBALCHAT="true"
HOSTNAME="Rust Server"
LEVELNAME="Procedural Map"
SERVERSEED="12345"
WORLDSIZE=3000
DESCRIPTION="Server Description"
TICKRATE=10
HEADERIMAGE=""

./RustDedicated -batchmode -logfile 2>&1 -nographics -server.ip 0.0.0.0 -server.port $SERVERPORT -rcon.port $RCONPORT -rcon.ip 0.0.0.0 -rcon.password "$RCONPASSWORD" -rcon.web 1 -server.maxplayers $MAXPLAYERS -server.globalchat $GLOBALCHAT  -server.hostname "$HOSTNAME" -server.identity "identity" -server.level "$LEVELNAME" -server.seed $SERVERSEED -server.worldsize $WORLDSIZE -server.description "$DESCRIPTION" -server.tickrate $TICKRATE -server.headerimage $HEADERIMAGE
