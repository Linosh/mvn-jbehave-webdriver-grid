#!/bin/sh

##### Parse props ####
OPTIONS=$(getopt -o hf:gb -l javaArgs:,nodePort:,hubHost:,hubPort:,nodeArgs: -- "$@")

if [ $? -ne 0 ]; then
  echo "getopt error"
  exit 1
fi

eval set -- $OPTIONS

while true; do
  case "$1" in
    --javaArgs)  JAVA_ARGS="$2" ; shift ;;
    --nodePort)  NODE_PORT="$2" ; shift ;;
    --hubHost)   HUB_HOST="$2"  ; shift ;;
    --hubPort)   HUB_PORT="$2"  ; shift ;;
    --nodeArgs)  NODE_ARGS="$2" ; shift ;;
    --)                           shift ; break ;;
    *)  echo "unknown option: $1" ; exit 1 ;;
  esac
  shift
done

if [ $# -ne 0 ]; then
  echo "unknown option(s): $@"
  exit 1
fi
######################


### Validate props ###
if [ -z $NODE_PORT ]
then
    echo "--nodePort is missed. Node didn't start"
    exit 1
fi

if [ -z $HUB_HOST ]
then
    echo "--hubHost is missed. Node didn't start"
    exit 1
fi

if [ -z $HUB_PORT ]
then
    echo "--hubPort is missed. Node didn't start"
    exit 1
fi
######################


##### Start Node #####
LOGFILE=./log$NODE_PORT
nohup java $JAVA_ARGS -jar selenium-server.jar -port $NODE_PORT -role node -hub http://$HUB_HOST:$HUB_PORT/grid/register $NODE_ARGS > $LOGFILE 2>&1 &
echo $! > pid$NODE_PORT
######################