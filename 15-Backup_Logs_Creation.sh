#!/bin/bash

TIMESTAMP=$(date)
mkdir -p /var/log/shellscript_logs
LOGDIR="/var/log/shellscript_logs"
FILENAME=$(echo "$0" | cut -d "." -f1)
LOGNAME="$LOGDIR/$FILENAME_$TIMESTAMP.log"
touch $LOGNAME
cd $LOGDIR
ls -l

