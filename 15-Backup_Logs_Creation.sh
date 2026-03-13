#!/bin/bash

SOURCE_DIR="/var/log/shellscript_logs"
ARCIEVE_DIR="/home/ec2-user/archieve_logs" #Destination directory for Backup logs and all logs are zipped

TIMESTAMP=$(date +%Y_%m_%d_%H_%M_%S)
mkdir -p $SOURCE_DIR
mkdir -p $ARCIEVE_DIR

FILENAME=$(echo $0 | cut -d "." -f1 )
echo "Log file name is : $FILENAME"
NAME="$FILENAME"_"$TIMESTAMP"
echo "Log file name with time stamp is : $NAME"
LOG_FILENAME="$SOURCE_DIR/$NAME.log"
#echo "Log file name is : $LOG_FILENAME" 

ROOT_USER=$(id -u)
if [ $? -eq 0 ]
then
    echo "Root user is executing the script at $TIMESTAMP" &>>$LOG_FILENAME
else
    echo "Root acccess is required to execute this script" &>>$LOG_FILENAME
    exit 1
fi

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

OLDFILES_MOVE_TO_ARCIEVE=$(find "$SOURCE_DIR" -name "*.log") #-mtime +1
echo "$OLDFILES_MOVE_TO_ARCIEVE"

BACKUP_LOGFILENAME="$ARCIEVE_DIR/backup_$OLDFILES_MOVE_TO_ARCIEVE_$TIMESTAMP.log"

cp "$SOURCE_DIR/$OLDFILES_MOVE_TO_ARCIEVE" "$ARCIEVE_DIR"


rm -rf "$SOURCE_DIR/$OLDFILES_MOVE_TO_ARCIEVE"

if [ $? -eq 0 ]
then
    echo "Files removed from"
else
    echo "Files removed from"
    exit 1
fi

#INSTALL_VALIDATE zip
#zip $ARCIEVE_DIR/* $BACKUP_LOGFILENAME

#while read -r line
#do
#    echo "$line"
#done <<< $OLDFILES

 


