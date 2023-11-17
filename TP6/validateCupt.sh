#!/usr/bin/bash
#Validate the format of a .cupt files
#Parameter
# $1 = a .cupt file (e.g. English-train.cupt)
#Return values:
#   0 - the format correct
#   1 - otherwise

#Number of columns in a cupt file 
NB_COLUMNS=11

#List of universal parts-of-speech
UPOS=("ADJ" "ADP" "ADV" "AUX" "CCONJ" "DET" "INTJ" "NOUN" "NUM" "PART" "PRON" "PROPN" "PUNCT" "SCONJ" "SYM" "VERB" "X" "_")

###############################################################################
# Prints an error message to stderr
# Parameters:
#   $1 - error code
#   $2 - a value to print in the error message
echoerr() 
{
   case $1 in
   0) echo "File format valid" >&2;;
   1) echo "line $line_number: Incorrect number of columns: $2 instead of $NB_COLUMNS" >&2;;
   2) echo "line $line_number: Incorrect part of speech: $2" >&2;;
   3) ;; #TODO
   4) echo "line $line_number: A line should be empty or start with a '#' or a digit." >&2;;
   5) echo "THE FILE HAS AN INVALID FORMAT!!" >&2;;
   *) echo "Unknown error code: $1" >&2;;
   esac
}

###############################################################################
# Check the number of fields in a word line of a .cupt file.
# A valid line should have exactly 11 columns, i.e; its filed
# Parameters:
#   $1 - number of fields in the line
# Return values:
#   0 - the number of fields is correct
#   1 - otherwise
checkSize() 
{
   if [ "$1" != "$NB_COLUMNS" ]; then
      echoerr 1 $1
      return 1
   fi
   return 0
}

###############################################################################
# Check that a part-of-speech label belongs to the UPOS list
# Parameters:
#   $1 - a part-of-speech label
# Return values:
#   0 - the label belongs to UPOS
#   1 - otherwise
checkPOS() 
{
   for pos in "${UPOS[@]}"; do
      #echo pos=$pos
      if [ "$pos" == "$1" ]; then
         return 0
      fi
   done
   echoerr 2 $1
   return 1
}

###############################################################################
# Check that a list of morphological features is correct.
# It should be equal to '_' or it should be a list of feature=value strings separated by a '|', e.g. Mood=Ind|Tense=Past|VerbForm=Fin
# Each feature starts with an uppercase letter
# Each feature or value is a combination of letters and digits
# Parameters:
#   $1 - a list of morphological features
# Return values:
#   0 - the list is correct
#   1 - otherwise
checkFEATS() 
{
   #TODO
   return 0
}


##############################################################################
#Check the format of a .cupt file. Stop on the first error, print error message and return an error code.
#Parameters:
# $1 = the file to check
#Return values:
#   0 - file correct
#   1 - a word line has an incorrect number of fields 
#   2 - a part-of-speech label is incorrect
#   3 - a list of morphological features is incorrect
#   4 - not an empty line and not starting with '#' or a digit
checkFile()
{
    line_number=0
    while read line; do
        line_number=$[$line_number+1]
        #echo "line=$line"
        if [[ "$line" =~ ^$ ]]; then 
            #echo "line $line_number: Empty line"
            continue
        elif [[ "$line" =~ ^# ]]; then 
            #echo "line $line_number: Comment line"
            continue
        elif [[ "$line" =~ ^[0-9\-]+ ]]; then
            #echo "line $line_number: Word line"
            #Split the line into an array
            read -r -a fields <<< $line

            #Check that the line has 11 columns
            checkSize ${#fields[@]}
            ret=$?; if [ "$ret" != "0" ]; then return 1; fi 
                
            #Check the part-of-speech
            checkPOS ${fields[3]}
            ret=$?; if [ "$ret" != "0" ]; then return 2; fi
            
            #Check the morphological features
            checkFEATS         #To complete with a parameter, once the function is programmed.
                               #Check the return value, quit if errors.
            
        else
            echoerr 4
            return 4
        fi
    done < $1
    return 0
}

###############################################################################""
#Checking the number of parameters
if [ $# -lt 1 ]; then
    echoerr "$0: 1 or more parameters needed: .cupt file names (e.g. English-train.cupt Georgian-test.cupt)"
    exit 1
fi 

errors=0
#Repeat for each file
until [ "$1" == "" ]; do 
    echo "======================================"
    echo "== File $1 "
    checkFile $1
    ret=$?
    if [ "$ret" -ne "0" ]; then 
        echoerr 5
        errors=$ret
    else
        echoerr 0
    fi
    #Go to the next parameter
    shift #shift all parameters

done #until
echo "======================================"
if [ "$errors" -ne "0" ]; then
    exit 1
else
    exit 0
fi


