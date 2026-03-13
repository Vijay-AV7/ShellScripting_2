#!/bin/bash

SOURCE_DIR="/var/log/shellscript_logs"
ARCIEVE_DIR="/home/ec2-user/archieve_logs" #Destination directory for Backup logs and all logs are zipped

TIMESTAMP=$(date +%Y_%m_%d_%H_%M_%S)
mkdir -p $SOURCE_DIR
mkdir -p $ARCIEVE_DIR

FILENAME=$(echo $0 | cut -d "." -f1 )
LOG_FILENAME="$SOURCE_DIR/$FILENAME"_"$TIMESTAMP.log" 
ZIP_FILENAME="$ARCIEVE_DIR/"Backup_"$FILENAME"_"$TIMESTAMP.log"
ROOT_USER=$(id)
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

OLDFILES_MOVE_TO_ARCIEVE=$( find "$SOURCE_DIR" -name "*.log" ) #-mtime +1
echo "Files to be deleted : $OLDFILES_MOVE_TO_ARCIEVE" &>>$LOG_FILENAME

INSTALL_VALIDATE zip

if [ ! -n "$FILES" ] # true if there are files to zip
then
    echo "Error:: No files found to take back up "
    exit 1
else
    for i in $OLDFILES_MOVE_TO_ARCIEVE
    do
        echo "File to be deleted : $i"
        echo "File to be deleted : $i" &>>$LOG_FILENAME
        cp "$SOURCE_DIR/$i" "$ARCIEVE_DIR" &>>$LOG_FILENAME
        VALIDATE $? "Copying files from $SOURCE_DIR to $ARCIEVE_DIR"
        rm -rf "$i"
        VALIDATE $? "Deleting files from $SOURCE_DIR"
        Zip $i "$ZIP_FILENAME"
        VALIDATE $? "Zipping the files in $ARCIEVE_DIR"
    done
fi



# BACKUP_LOGFILENAME="$ARCIEVE_DIR/backup_$OLDFILES_MOVE_TO_ARCIEVE_$TIMESTAMP.log"
# cp "$SOURCE_DIR/$OLDFILES_MOVE_TO_ARCIEVE" "$ARCIEVE_DIR"
# rm -rf "$SOURCE_DIR/$OLDFILES_MOVE_TO_ARCIEVE"
# if [ $? -eq 0 ]
# then
#     echo "Files removed from"
# else
#     echo "Files removed from"
#     exit 1
# fi


#zip $ARCIEVE_DIR/* $BACKUP_LOGFILENAME

#while read -r line
#do
#    echo "$line"
#done <<< $OLDFILES

 


