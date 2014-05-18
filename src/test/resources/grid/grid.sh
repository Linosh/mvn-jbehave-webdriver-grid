#!/bin/sh



function debug {
    if [ -n "$GRID_DEBUG" ]; then
        v=$1
        if [ -n "${!v}" ]; then
            echo $1": "${!v}
        fi
    fi
}

function getOr  {
    propName=$1
    default=$2

    if [ -n "${!propName}" ]; then
        echo "${!propName}";
    else
        echo "$default"
    fi
}

function startGridInstance {
   SSH_HOST=$1
   SSH_PORT=$2
   SSH_USER=$3
   COMMAND=$4


   debug "SSH_HOST"
   debug "SSH_PORT"
   debug "SSH_USER"
   debug "COMMAND"


   if [ -n "$SSH_HOST" ]; then
        echo "-> Exucuting on remote machine $HUB_SSH_HOST:$HUB_SSH_PORT"
        ssh $SSH_USER@$SSH_HOST -p $SSH_PORT -f -n $COMMAND
   else
        echo "-> Executing locally"
        c=`pwd`
        eval $COMMAND
        cd $c
   fi
}

function startHub {
    echo "-> Starting HUB"
    startGridInstance "`getOr 'HUB_SSH_HOST' ''`" "`getOr 'HUB_SSH_PORT' ''`" "`getOr 'HUB_SSH_USER' ''`" "cd $HUB_HOME; ./startHub.sh $HUB_PORT"
    echo
}

function stopHub {
    echo "-> Stoping HUB"
    startGridInstance "`getOr 'HUB_SSH_HOST' ''`" "`getOr 'HUB_SSH_PORT' ''`" "`getOr 'HUB_SSH_USER' ''`" "cd $HUB_HOME; ./stopHub.sh"
    echo
}

function startNodes {
    for node in ${NODES_TO_START[*]}
    do
        source $node/node.properties;

        echo "-> Starting Node: $NODE_NAME";

        CMD="cd $NODE_HOME; ./startNode.sh --nodePort $NODE_PORT --hubHost '$HUB_HOST' --hubPort $HUB_PORT"

        if [ -n "$JAVA_ARGS" ]; then
          CMD=$CMD" --javaArgs \"$JAVA_ARGS\""
        fi

        if [ -n "$NODE_ARGS" ]; then
          CMD=$CMD" --nodeArgs \"$NODE_ARGS\""
        fi

        startGridInstance "`getOr 'NODE_SSH_HOST' ''`" "`getOr 'NODE_SSH_PORT' ''`" "`getOr 'NODE_SSH_USER' ''`" "$CMD"

        echo
    done
}

function stopNodes {
    for node in ${NODES_TO_START[*]}
    do
        source $node/node.properties;

        echo "-> Stoping Node: $NODE_NAME";

        startGridInstance "`getOr 'NODE_SSH_HOST' ''`" "`getOr 'NODE_SSH_PORT' ''`" "`getOr 'NODE_SSH_USER' ''`" "cd $NODE_HOME; ./stopNode.sh $NODE_PORT"

        echo
    done
}

function printUsage {
    echo "+===================================================================================+"
    echo "+ How to use:                                                                       +"
    echo "+  - To start Grid execute ./grid.sh start                                          +"
    echo "+  - To stop Grid execute ./grid.sh stop                                            +"
    echo "+  - To enable debug mode set env var: GRID_DEBUG=true                              +"
    echo "+                                                                                   +"
    echo "+ For internal details plz check the code and provided comments for each function   +"
    echo "+===================================================================================+"
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
