#!/bin/sh
LOGFILE=./log
nohup java -jar selenium-server.jar -port $1 -role hub > $LOGFILE 2>&1 &
echo $! > pid