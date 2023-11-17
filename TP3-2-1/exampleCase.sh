#!/bin/bash
#Print basic system data
#The choice of the data to display is done with a menu
#No input parameter

#Display the menu
echo "What do you wish to know?"
echo "1 - basic data about the local host"
echo "2 - data about the working environment"
echo "3 - user identity data"
echo "4 - quit"
echo "5 - perso"

#Read the choice from input
read choice

#Execute the chosen option
case $choice in
1)
	echo "You work on host `hostname`. "
	echo "Its architecture is `arch`."
	echo "Its current date and time is `date`"
  	;;
2)
	echo "Your operating system is `uname`."
	echo "Your working directory is `pwd`. It occupies a disk space of `du -hs | cut -f1` bytes."
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
5)
	echo "c'est mon choix pers `uptime`"
	exit 1;
	;;
*)
        echo "Incorrect choice!"
	exit 1;
	;;
esac


