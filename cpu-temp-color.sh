#!/bin/sh
#Colour list:
#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37
#
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
ON_GREEN='\033[42m'
ON_YELLOW='\033[43m'
ON_BLUE='\033[44m'
IRED='\033[1;91m' 
IGREEN='\033[1;92m'
IYELLOW='\033[1;93m' 
NC='\033[0m' # No Color




echo "${BYELLOW}Automated CPU Temperature Monitor${NC}"
echo "${BGREEN}(^C to quit)${NC}\n"

while :
do

TEMP_FILE=/sys/class/thermal/thermal_zone0/temp

ORIGINAL_TEMP=$(cat $TEMP_FILE)
TEMP_C=$((ORIGINAL_TEMP/1000))
TEMP_F=$(($TEMP_C * 9/5 + 32))
date=$(date '+(%d-%m-%Y %H:%M:%S)')

echo "${BGREEN}$date"
if [ $TEMP_C -lt 35 ] 
        then echo "${YELLOW}Current Temperature:" "${BGREEN}$TEMP_C C" 
elif [ $TEMP_C -eq 36-80 ] 
        then echo "${YELLOW}Current Temperature:" "${BYELLOW}$TEMP_C C"
elif [ $TEMP_C -gt 81 ]
        then echo "${YELLOW}Current Temperature:" "${BRED}${URED}$TEMP_C C"
fi
  sleep 15
done