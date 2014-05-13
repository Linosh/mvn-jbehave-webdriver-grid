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


LOGFILE=./log
nohup java $1 -jar selenium-server.jar -port $2 -role node -hub http://$3:$4/grid/register $5 > $LOGFILE 2>&1 &
echo $! > pid