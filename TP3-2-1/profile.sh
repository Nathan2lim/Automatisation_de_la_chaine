#!/bin/bash
#Creating user profiles
#A user profile is a text file containing (in one line) the user's surname, given name, gender and age.
#The file name contains the given name, followed by a dash, followed by the surname.
#The profile is created if it does not yet exist.
#Parameters:
# $1 = surrname
# $2 = given name
# $3 = gender (f or m)
#Return values: 0 if no error, 1 if too few parameters, 2 is age is negatif

#Checking the number of parameters
#The '#' special variable represents the number of parameters input in the command line
if [ $# != 3 ]; then
    echo "$0: 3 parameters needed: surname, given name, gender (f=female, m=male, o=other, u=unwilling to say)" >&2
    exit 1
fi 

#Print a welcome message depending on the user's gender.
if [ "$3" == 'f' ]; then
	echo -n "Dear Madame $1,"
else
	if [ "$3" == 'm' ]; then
		echo -n "Dear Sir $1,"
	else 
		echo -n "Dear $2 $1,"
	fi
		
fi
echo " welcome to the script creating your profile."

#Check if the user profile exists
if [ -f profiles/$2-$1 ]; then
	echo -n "Your profile already exists: " 
	cat profiles/$2-$1
else
    #Scanning the user's age
    echo -n "Your age: "
    read age
    if [ $age -lt 0 ]; then
	echo "Sorry, your age cannot be negative. Bye..."
	exit 2
    fi
    
    #Creating the profile
    echo $1 $2 $3 $age > profiles/$2-$1
    if [ $? -ne 0 ]; then
	echo "Your profile could not be created."
    else
	echo "Your profile has been successfully created." 
    fi
fi
