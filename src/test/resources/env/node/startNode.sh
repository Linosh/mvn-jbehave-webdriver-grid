#!/bin/sh
LOGFILE=./log
nohup java $1 -jar selenium-server.jar -port $2 -role node -hub http://$3:$4/grid/register $5 > $LOGFILE 2>&1 &
echo $! > pid