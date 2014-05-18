#!/bin/sh

function debug {
    if [ -n "$GRID_DEBUG" ]; then
        v=$1
        if [ -n "${!v}" ]; then
            echo $1": "${!v}
        fi
    fi
}

##### Parse props ####
### Start using hand made parser 'cause this script should work not only on *nix OSs
JAVA_ARGS=""
NODE_PORT=""
HUB_HOST=""
HUB_PORT=""
NODE_ARGS=""
while : ; do
  case "$1" in
    --javaArgs)
       [ -n "${JAVA_ARGS}" ] && usage
       JAVA_ARGS="$2"
       shift 2 ;;
    --nodePort)
       [ -n "${NODE_PORT}" ] && usage
       NODE_PORT="$2"
       shift 2 ;;
    --hubHost)
       [ -n "${HUB_HOST}" ] && usage
       HUB_HOST="$2"
       shift 2 ;;
    --hubPort)
       [ -n "${HUB_PORT}" ] && usage
       HUB_PORT="$2"
       shift 2 ;;
    --nodeArgs)
       [ -n "${NODE_ARGS}" ] && usage
       NODE_ARGS="$2"
       shift ;;
    *)
       break ;;
  esac
done
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