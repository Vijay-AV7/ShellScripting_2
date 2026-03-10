#!/bin/bash

W="\e[0m" #WHITE
R="\e[31m" #RED
G="\e[32m" #GREEN
Y="\e[33m" #YELLOW

TIMESTAMP_START=$(date)
USER_ID=$(id -u)

# &>> this command will append all the outputs to the log

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d_%H:%M:%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE_$TIMESTAMP.log"

VALIDATE () {

    dnf list installed $1 &>>$LOG_FILE_NAME

if [ $? -eq 0 ]
then 
    echo -e "$Y INFORMATION$W:: $1 .... already installed" 
else
    dnf install $1 -y &>>$LOG_FILE_NAME
    if [ $? -eq 0 ]
    then 
        echo -e "$1 .... installed successfully" 
    else    
        echo -e "$R ERROR$W:: $1 .... installed $R Failure$W"
        exit 1
    fi
fi  
}

if [ $USER_ID -ne 0 ]
then  
        echo -e "ERROR:: You must have the sudo access to execute this script"
        exit 1
else 
        echo "$USER user started executing the script at : $TIMESTAMP_START" &>>$LOG_FILE_NAME
fi

VALIDATE mysql
VALIDATE git
