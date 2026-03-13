#!/bin/bash

SOURCE_DIR="/var/log/shellscript_logs"
ARCHIVE_DIR="/home/ec2-user/archieve_logs" #Destination directory for Backup logs and all logs are zipped

TIMESTAMP=$(date +%Y_%m_%d_%H_%M_%S)
mkdir -p $SOURCE_DIR
mkdir -p $ARCHIVE_DIR

FILENAME=$(echo $0 | cut -d "." -f1 )
LOG_FILENAME="$SOURCE_DIR/$FILENAME"_"$TIMESTAMP.log" 
ZIP_FILENAME="$ARCHIVE_DIR/"Backup_"$FILENAME"_"$TIMESTAMP.zip"
ROOT_USER=$(id -u)
if [ $? -eq 0 ]
then
    echo "Root user is executing the script at $TIMESTAMP" &>>$LOG_FILENAME # "&>>"" this command will create the file if not exists and append the data
else
    echo "Root acccess is required to execute this script" &>>$LOG_FILENAME
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
        echo "ERROR::$1 installation .... failure"
        exit 1
    fi
fi 
}

VALIDATE (){
if [ $1 -eq 0 ]
then
    echo "$2 .... successful"
else
    echo "ERROR:: $2 .... failed"
    exit 1
fi
}

OLDFILES_MOVE_TO_ARCHIVE=$( find "$SOURCE_DIR" -name "*.log" ) #-mtime +1
echo "Files to be deleted : $OLDFILES_MOVE_TO_ARCHIVE" &>>$LOG_FILENAME

INSTALL_VALIDATE zip

if [ -n "$OLDFILES_MOVE_TO_ARCHIVE" ] # if variable is non‑empty then true to zip files
then
    zip "$ZIP_FILENAME" $OLDFILES_MOVE_TO_ARCHIVE &>>$LOG_FILENAME
    VALIDATE $? "Zipping the files in $ARCHIVE_DIR"
    for i in $OLDFILES_MOVE_TO_ARCHIVE
    do
        echo "File to be deleted : $i" &>>$LOG_FILENAME
        rm -rf "$i" &>>$LOG_FILENAME
        VALIDATE $? "Deleting files from $SOURCE_DIR"
    done
else
    echo "Error:: No files found to take back up "
    exit 1
fi