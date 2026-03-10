#!/bin/bash

DBUSERNAME=Vijay@32
DBPASSWORD=123

echo "Please enter you username :"
read USERNAME
echo "USERNAME entered : $USERNAME"
echo "Please enter your password :"
read -s PASSWORD

#If we are comparing the strings use below
# == or = → equal 
# != → not equal
# < → less than (in ASCII order)
# > → greater than (in ASCII order)
# -z STRING → true if string is empty
# -n STRING → true if string is not empty

if [ -n "$USERNAME" ]
then
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
else 
    echo "No username is entered, "
fi
