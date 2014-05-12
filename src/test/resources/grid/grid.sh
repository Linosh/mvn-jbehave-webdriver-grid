#!/bin/sh

NODES_TO_START=(chrome firefox)

case "$1" in
'start')
    echo "Starting Grid"
    startHub
    startNodes
;;

'stop')
    echo "Stopping Grid"
    stopHub
    stopNodes
;;
'restart')
    echo "Restarting Grid"
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
    source hub/hub.properties;
    echo "Starting HUB on $HUB_SSH_HOST:$HUB_PORT";
    ssh $HUB_SSH_USER@$HUB_SSH_HOST:$HUBSSH_PORT -f -n "cd $HUB_HOME; ./startHub.sh"
}

function stopHub {
    source hub/hub.properties;
    echo "Stoping HUB on $HUB_SSH_HOST:$HUB_PORT";
    ssh $HUB_SSH_USER@$HUB_SSH_HOST:$HUBSSH_PORT -f -n "cd $HUB_HOME; ./stopHub.sh"
}

function startNodes {
    for node in ${NODES_TO_START[*]}
    do
        source $node/node.properties;
        echo "Starting Node on $NODE_SSH_HOST:$NODE_PORT";
    done
}

function stopNodes {
    source hub/hub.properties;
    echo "Starting HUB on $HUB_SSH_HOST:$HUB_PORT";
}

function printUsage {
    echo "Simple Instruction should be here ;)"
}