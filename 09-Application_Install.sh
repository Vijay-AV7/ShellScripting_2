#!/bin/bash

TIMESTAMP_START=$(date)
USER_ID=$(id -u)

W=e\[0m #WHITE
R=e\[31m #RED
G=e\[32m #GREEN
Y=e\[33m #YELLOW

if [ $USER_ID -ne 0 ]
then  
        echo -e "ERROR:: You must have the sudo access to execute this script"
        exit 1
else 
        echo "$USER user started executing the script at : $TIMESTAMP_START"
fi

dnf list installed mysql

if [ $? -eq 0 ]
then 
    echo -e "$Y INFORMATION$W:: Mysql .... already installed" 
else
    dnf install mysql -y
    if [ $? -eq 0 ]
    then 
        echo "Mysql .... installed successfully" 
    else    
        echo "$R ERROR$W:: Mysql .... installed $R Failure$W"
        exit 1
    fi
fi  

dnf list installed git

if [ $? -eq 0 ]
then 
    echo "$Y INFORMATION$W:: Git .... already installed" 
else
    dnf install git -y
    if [ $? -eq 0 ]
    then 
        echo "Git .... installed $G successfully $W" 
    else    
        echo "$R ERROR$W:: Git .... installed $R Failure $W"
        exit 1
    fi
fi  