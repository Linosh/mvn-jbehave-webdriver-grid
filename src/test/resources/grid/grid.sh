#!/bin/sh

############ Working with props

OPTIONS=$(getopt -o hf:gb -l help,file:,foo,bar -- "$@")

if [ $? -ne 0 ]; then
  echo "getopt error"
  exit 1
fi

eval set -- $OPTIONS

while true; do
  case "$1" in
    -h|--help) HELP="$2" ; shift ;;
    -f|--file) FILE="$2" ; shift ;;
    -g|--foo)  FOO="$2" ; shift ;;
    -b|--bar)  BAR="$2" ; shift ;;
    --)        shift ; break ;;
    *)         echo "unknown option: $1" ; exit 1 ;;
  esac
  shift
done

if [ $# -ne 0 ]; then
  echo "unknown option(s): $@"
  exit 1
fi

echo "help: $HELP"
echo "file: $FILE"
echo "foo: $FOO"
echo "bar: $BAR"



###############################



source grid.properties

case "$1" in
'start')
    echo 'Starting Grid'
    startHub
    startNodes
;;

'stop')
    echo 'Stopping Grid'
    stopHub
    stopNodes
;;
'restart')
    echo 'Restarting Grid'
    stopHub
    stopNodes

    startHub
    startNodes
;;
* )
    printUsage
;;
esac


function startHub {
    echo "Starting HUB on $HUB_SSH_HOST:$HUB_PORT"
    ssh $HUB_SSH_USER@$HUB_SSH_HOST:$HUBSSH_PORT -f -n 'cd $HUB_HOME; ./startHub.sh' $HUB_PORT
}

function stopHub {
    echo "Stoping HUB on $HUB_SSH_HOST:$HUB_PORT"
    ssh $HUB_SSH_USER@$HUB_SSH_HOST:$HUBSSH_PORT -f -n 'cd $HUB_HOME; ./stopHub.sh'
}

function startNodes {
    for node in ${NODES_TO_START[*]}
    do
        source $node/node.properties;
        echo "Starting Node on $NODE_SSH_HOST:$NODE_PORT";
        ssh $NODE_SSH_USER@$NODE_SSH_HOST:$NODE_SSH_PORT -f -n 'cd $NODE_HOME; ./startNode.sh' $JAVA_PARAMS $NODE_PORT $HUB_HOST $HUB_PORT $NODE_PARAMS
    done
}

function stopNodes {
    source hub/hub.properties;
    echo "Starting HUB on $HUB_SSH_HOST:$HUB_PORT";
}

function printUsage {
    echo "Simple Instruction should be here ;)"
}