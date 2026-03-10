#!/bin/bash

TIMESTAMP_START=$(date)
USER_ID=$(id -u)

W="\e[0m" #WHITE
R="\e[31m" #RED
G="\e[32m" #GREEN
Y="\e[33m" #YELLOW

VALIDATE () {

    dnf list installed $1

if [ $2 -eq 0 ]
then 
    echo -e "$Y INFORMATION$W:: $1 .... already installed" 
else
    dnf install $1 -y
    if [ $2 -eq 0 ]
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
        echo "$USER user started executing the script at : $TIMESTAMP_START"
fi

VALIDATE mysql $?
VALIDATE git $?
