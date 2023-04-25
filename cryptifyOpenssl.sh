#!/bin/sh
#
clear
# Declare color variables
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
URED='\033[4;31m'
ON_RED='\033[41m'
ON_BLUE='\033[44m'
ON_GREEN='\033[42m'
NC='\033[0m' # No Color

echo ${BBLUE}"+----------------------------------------+"${NC}
echo ${ON_BLUE}"|--------------=[Cryptify]=--------------|"${NC} 
echo ${ON_GREEN}"|------File and Directory encryptor------|"${NC}
echo ${BBLUE}"+----------------------------------------+"${NC}
echo ${BGREEN}"Welcome to Cryptify! the simple file and directory encryptor!"${NC}
echo ${GREEN}"Please enter the file or directoy to work with:"${NC}
read DIR

#Create crypt function:
crypt () {
	openssl aes-256-cbc -salt -iter 5 -in $DIR -out $DIR.enc ;
}
#Create decrypt function:
decrypt () {
	openssl enc -d aes-256-cbc -in $DIR.enc -out $DIR.data ;
}

echo ${GREEN}"What would you like to do? (Encrypt = e or decrypt = d):"${NC}
read task
case $task in
	[Ee]* ) if crypt ; 
		then echo ${ON_GREEN}"Encryption Successful!"${NC};
		else echo ${ON_RED}"Encryption Failed."${NC};
		fi;;
	[Dd]* ) if decrypt ; 
		then echo ${ON_GREEN}"Decryption Successful!"${NC};
		else echo ${ON_RED}"Decryption Failed."${NC};
		fi;;
	* ) echo ${URED}"Please enter a valid selection 'e/E' or 'd/D'."${NC};;
esac

while true; do
    echo ${GREEN}"Do you wish to remove original file/directory?"${NC} 
    read yn
    case $yn in
        [Yy]* ) rm -r $DIR; break;;
        [Nn]* ) exit;;
        * ) echo ${URED}"Please answer yes or no."${NC};;
    esac
done
echo ${BYELLOW}"Program Terminated"${NC}
