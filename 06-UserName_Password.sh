#!/bin/bash

DBUSERNAME=Vijay@32
DBPASSWORD=123

echo "Please enter you username :"
read USERNAME
echo "USERNAME entered : $USERNAME"
echo "Please enter your password :"
read -s PASSWORD

if [ $DBUSERNAME == $USERNAME ]
then
    if [ $DBPASSWORD -eq $PASSWORD ]
    then
        echo "Log in successful ...."
    else
        echo "incorrect Password"
    fi
else
        echo "Incorrect Username"
fi
