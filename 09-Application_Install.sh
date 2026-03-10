#!/bin/bash

TIMESTAMP_START=$(date)
USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]
then  
        echo "ERROR:: You must have the sudo access to execute this script"
        exit 1
else 
        echo "$USER user started executing the script at : $TIMESTAMP_START"
fi

dnf list installed mysql

if [ $? -eq 0 ]
then 
    echo "Mysql .... already installed" 
else
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "Mysql .... installed successfully" 
    else    
        echo "ERROR:: Mysql .... installed Failure"
        exit 1
    fi
fi    