#!/bin/bash
# Parameters:
# $1=nameofauser
# $2 = first grade
# $3 = second grade
# Displays the average grade of the user.

#declare une variable x qui vos int 1 
#fait moi une boucle for qui va de 1 a $# (nombre de parametre)

#./maketreeParam.sh fr es ed es 
#                   $1 $2 $3 $4
rm -rdf Corpus
mkdir -p Corpus
echo "CREATING directory Corpus"
cd Corpus

for (( c=1; c<=$#; c++ ))
    
    do

        ################### NIVEAU 1 ############################
        mkdir -p ${!c}-data 
        echo "CREATING directory"${!c} "-data"

        mkdir -p BIN
        echo "CREATING directory BIN"

        touch ReadMe.md

        ################### NIVEAU 2 FR-DATA ############################
        cd ${!c}-data 

        touch train.scupt
        echo "CREATING file train.scupt"

        ln -s ../BIN/  Script
        echo "CREATING symbolic link to BIN"

        ln ../ReadMe.md readme-all.md
        echo "CREATING symbolic link to ReadMe.md"

        cd ../

    done

tree

