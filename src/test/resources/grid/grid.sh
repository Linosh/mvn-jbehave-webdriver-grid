#!/bin/sh

function startHub {
    echo "-> Starting HUB: $HUB_SSH_HOST:$HUB_PORT"
    ssh $HUB_SSH_USER@$HUB_SSH_HOST -p $HUB_SSH_PORT -f -n 'cd $HUB_HOME; ./startHub.sh' $HUB_PORT
}

function stopHub {
    echo "-> Stoping HUB: $HUB_SSH_HOST:$HUB_PORT"
    ssh $HUB_SSH_USER@$HUB_SSH_HOST -p $HUB_SSH_PORT -f -n 'cd $HUB_HOME; ./stopHub.sh'
}

function startNodes {
    for node in ${NODES_TO_START[*]}
    do
        source $node/node.properties;
        echo "-> Starting Node: $NODE_SSH_HOST:$NODE_PORT";
        ssh $NODE_SSH_USER@$NODE_SSH_HOST -p $NODE_SSH_PORT -f -n 'cd $NODE_HOME; ./startNode.sh' "--nodePort $NODE_PORT --hubHost \"$HUB_HOST\" --hubPort $HUB_PORT --nodeArgs \"$NODE_PARAMS\""
    done
}

function stopNodes {
    for node in ${NODES_TO_START[*]}
    do
        source $node/node.properties;
        echo "-> Stoping Node: $NODE_SSH_HOST:$NODE_PORT";
        ssh $NODE_SSH_USER@$NODE_SSH_HOST -p $NODE_SSH_PORT -f -n 'cd $NODE_HOME; ./stopNode.sh' $NODE_PORT
    done
}

function printUsage {
    echo "RTFM!!!"
}

source grid.properties

case "$1" in
'start')
    echo 'Starting Grid:'
    startHub
    startNodes
;;

'stop')
    echo 'Stopping Grid:'
    stopHub
    stopNodes
;;
'restart')
    echo 'Restarting Grid:'
    stopHub
    stopNodes

    startHub
    startNodes
;;
* )
    printUsage
;;
esac
