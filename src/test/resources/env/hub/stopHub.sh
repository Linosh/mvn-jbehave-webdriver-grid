#!/bin/sh

if [ -f pid ]
then
    kill `cat pid`
    rm pid
else
    echo "File pid doesn't exist" >> log
fi