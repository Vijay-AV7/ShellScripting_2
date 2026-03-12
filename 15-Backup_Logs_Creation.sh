#!/bin/bash

TIMESTAMP=$(date +%Y/%m/%d_%H_%M_%S)
mkdir -p /var/log/shellscript_logs
LOGDIR="/var/log/shellscript_logs"
FILENAME=$(echo $0 | cut -d "." -f1)
LOG_FILENAME="$LOGDIR/$FILENAME_$TIMESTAMP.log"
echo "Log file name is : $LOG_FILENAME" 

SOURCE_DIR=$LOGDIR
ARCIEVE_DIR="/home/ec2-user/archieve_logs"

INSTALL_VALIDATE () {

dnf list installed $1 &>>$LOG_FILENAME
if [ $? -eq 0 ]
then
    echo "$1 is already installed"
else
    dnf install $1 -y &>>$LOG_FILENAME
    if [ $? -eq 0 ]
    then
        echo "$1 installation .... successful"
    else
        echo " .$1 installation .... failure"
        exit 1
    fi
fi 
}

INSTALL_VALIDATE mysql 


