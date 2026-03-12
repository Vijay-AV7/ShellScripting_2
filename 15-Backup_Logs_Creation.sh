#!/bin/bash

TIMESTAMP=$(date)
mkdir -p /var/logs/shellscript_logs
LOGDIR="/var/logs/shellscript_logs"
FILENAME=$(echo "$0" | cut -d "." -f1)
LOGNAME=$(touch "$LOGDIR/$FILENAME_TIMESTAMP.log")

echo $LOGNAME
cd $LOGDIR
ls -l

