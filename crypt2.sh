#!/bin/sh
#
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
NC='\033[0m' # No Color

echo ${ON_BLUE}"File Encrypter"${NC} 
read -p "Enter the files full directoy:" DIR
read -p "Enter the file name:" FILE
FILE_LOC="$DIR$FILE"
echo $FILE_LOC
#create crypt function
crypt () {
    openssl aes-256-cbc -a -salt -iter 5 -in $FILE_LOC -out $FILE.enc ;
}
echo ${ON_BLUE}"Encrypting file..."${NC}
if crypt ; then
    echo ${ON_BLUE}"Encryption Successful!"${NC}
else
    echo ${ON_RED}"Encryption Failed."${NC}
fi

while true; do
    read -p "Do you wish to remove original file?" yn
    case $yn in
        [Yy]* ) rm -r $FILE_LOC; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done