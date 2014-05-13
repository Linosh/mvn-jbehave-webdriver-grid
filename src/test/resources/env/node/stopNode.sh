#!/bin/sh

if [ -f pid$1 ]
then
    kill `cat pid$1`
    rm pid$1
else
    echo "File pid$1 doesn't exist" >> log$1
fi