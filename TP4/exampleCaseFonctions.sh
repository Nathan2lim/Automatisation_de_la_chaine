#!/bin/bash
#Print basic system data
#The choice of the data to display is done with a menu
#No input parameter

#####################################################################
#Traitement: Display the menu and read the option chosen by the user
#Output: the number of the option chosen by the user (from 1 to 4)
menu () {
#Display the menu
echo "What do you wish to know?"
echo "1 - basic data about the local host"
echo "2 - data about the working environment"
echo "3 - user identity data"
echo "4 - quit"

#Read the choice from input and return it
read choice
return $choice
}

#####################################################################
#Display system data according to a chosen option
#Input: $1 = option number
#Output: 1 on option error, 0 otherwise

options () {
case $1 in
#Execute the chosen option
1)
	echo "You work on host `hostname`. "
	echo "Its architecture is `arch`."
  	;;
2)
	echo "Your operating system is `uname`."
	echo "Your working directory is `pwd`. It occupies a disk space of `du -hs | cut -f1` bytes ."
	echo "Your current console is associated to the special file `tty`."
  	;;
3)
	echo "Your login is `whoami` and your UID is `id -u`."
	echo "You belong to the following groups: `groups`. Your current GID is `id -g`."
	;;
4)
        echo "Thank you for reading! Bye..."
	exit 0;
	;;
*)
        echo "Incorrect choice!"
	exit 1;
	;;
esac
}

#####################################################################
# The main script starts here

while true;
do
menu
choice=$?
options $choice
done

