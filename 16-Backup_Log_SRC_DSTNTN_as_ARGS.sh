#!/bin/bash

# /var/log/shellscript_logs
# /home/ec2-user/archieve_14MAR

SOURCE_DIR=$1
ARCHIVE_DIR=$2 #Destination directory for Backup logs and all logs are zipped
DAYS=${3:-14} # if user is not providing number of days, we are taking 14 as default

DIRECTORY_CHECK (){
if [ -n $1 ] || [ -d $1 ]
then
    echo "$2 is loaded .... successfully"
else
    echo "echo "$2 is not valid .... failed""
    exit 1
fi
}

USAGE(){
    echo -e "USAGE:: backup <SOURCE_DIR> <DEST_DIR> <DAYS(Optional)>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

DIRECTORY_CHECK $SOURCE_DIR "Source directory"
DIRECTORY_CHECK $ARCHIVE_DIR "Archieve directory"

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

for i in {0..7}
do
    touch $LOG_FILENAME
done

OLDFILES_MOVE_TO_ARCHIVE=$( find "$SOURCE_DIR" -name "*.log" ) #-mtime +1
echo "Files to be deleted : $OLDFILES_MOVE_TO_ARCHIVE" &>>$LOG_FILENAME

INSTALL_VALIDATE zip

if [ -n "$OLDFILES_MOVE_TO_ARCHIVE" ] # if variable is non‑empty then true to zip files
then
    zip "$ZIP_FILENAME" $OLDFILES_MOVE_TO_ARCHIVE &>>$LOG_FILENAME
    VALIDATE $? "Zipping the files in $ARCHIVE_DIR"
    for i in $OLDFILES_MOVE_TO_ARCHIVE
    do
        echo "File to be deleted : $i from $SOURCE_DIR" &>>$LOG_FILENAME
        echo "File to be deleted : $i"
        rm -rf "$i" &>>$LOG_FILENAME
        VALIDATE $? "File is deleted : $i "
    done
else
    echo "Error:: No files found to take back up "
    exit 1
fi