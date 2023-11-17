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

#Make a createCorpus() function. It should create the root directory for the corpus, with a global README.md file and a bin/ subdirectory.
createCorpus()
{
    rm -rdf Corpus

    mkdir -p Corpus
        echo "CREATING directory Corpus"

    mkdir -p BIN
        echo "CREATING directory BIN"

    touch ReadMe.md
}
cd Corpus

#Make a checkDir() function. It should take a course name as a parameter and check if its directory exists. If it does, the function should ask the user if the directory should be re-created. The function should return one of the three values:
#• 0 if the directory does not exist yet,
#• 1 if it exists and should NOT be re-created, • 2 if it exists and should be re-created.

checkDir()
{
    if [ -d $1-data ]
    then
        echo "The directory $1-data already exists."
        echo "Do you want to re-create it? (y/n)"
        read answer
        if [ $answer = "y" ]
        then
            return 2
        else
            return 1
        fi
    else
        return 0
    fi
}

#Make a createDir() function. It should take a course name as a parameter and create a directory for this course as before. It should have no return value.

createDir()
{
    mkdir -p $1-data 
        echo "CREATING directory $1-data"

    mkdir -p BIN
        echo "CREATING directory BIN"

    touch ReadMe.md
}


for (( c=1; c<=$#; c++ ))
    
    do
    checkDir()
    if [ $? = 0 ]
    then
        createDir()
    elif [ $? = 2 ]
    then
        rm -rdf $1-data
        createDir()
    fi

        ################### NIVEAU 1 ############################
      #  mkdir -p ${!c}-data 
#        echo "CREATING directory"${!c} "-data"

        

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

