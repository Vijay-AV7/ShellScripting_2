#!/bin/bash

NAME1=Rahim 
NAME2=Robert

#NAME1, NAME2 are two variables
#When the string data is passed to the variables better to use "$NAME1" / "$NAME2"

echo "$NAME1:: Hi ${NAME2}"
echo "$NAME2:: Hello $NAME1"
echo "$NAME1:: How are you doing?"
echo "$NAME2:: I am good. How are you?"