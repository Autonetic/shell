#!/bin/bash
#File backup script

#elevate privileges to sudo...
if [ "$EUID" != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi


#my stupid program intro...
echo -e "\033[1;35m+-----------------------------------------+\033[0m"
echo -e "\033[1;35m|\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\|\033[0m"
echo -e "\033[1;35m|-----------=[ \033[0m\033[1;32mBackup Script\033[0m\033[1;35m ]=-----------|\033[0m"
echo -e "\033[1;35m|-------------=(\033[0;35m^C to quit\033[1;35m)=--------------|\033[0m"
echo -e "\033[1;35m|/\/\/\/\/\/\033[0m\033[1;33mCoded@ Autonetix.co\033[0m\033[1;35m/\/\/\/\/\/|\033[0m"
echo -e "\033[1;35m+-----------------------------------------+\033[0m \n"


#set some colours for output readability...
BRED='\033[1;31m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
BGREEN='\033[1;32m'
NC='\033[0m'


#create some functions to controll the flow of the program...
compress_backup () { tar -zcvf "$FOLDER.tar.gz" "$FOLDER"; }
change_ownership () { chown "$EXECUTOR:$EXECUTOR" "$FOLDER"; }
copy_files () { cp -r "$path" "$FOLDER"; }

#define some variables...
EXECUTOR="${SUDO_USER:-${USER}}"
date=$(date '+%d-%m-%Y-%H.%M')

if [ -d "backup-$date" ]; then
        FOLDER="backup-$date-2"
        else
                mkdir "backup-$date" && FOLDER="backup-$date"
fi


# Paths to be backed up...
echo -e "${BYELLOW}Please enter whitespace-separated paths that you wish to backup. eg /var/www /var/log etc.:${NC}"
read -a PATHS
for PATH in "${PATHS[@]}"
do
        copy_files
        echo "copied... $PATH"
done

echo -e "${BYELLOW}files backed up to${NC} ${BBLUE}$FOLDER${NC} \n"
echo -e "${BYELLOW}Would you like to compress the backup? 'yes' or 'no'?${NC}"

read INPUT

if [ "$INPUT" = yes ]; then
	echo -e "Changing ownership of ${BBLUE}$FOLDER${NC}"
	if change_ownership; then
		echo -e "${BGREEN}Ownership aquired for${NC} ${BBLUE}$EXECUTOR${NC}${BGREEN}...${NC}"
	else
		echo -e "${BRED}Ownership could not be aquired!${NC}"
		exit 1
	fi
        echo -e "${BYELLOW}Compressing backup...${NC}"
	if compress_backup; then
		echo -e "${BBLUE}$FOLDER.tar.gz${NC} ${BYELLOW}has been created...${NC}"
                echo -e "${BGREEN}Backup completed successfully!${NC}"
        else
                echo -e "${BRED}Something went wrong whilst running compression!${NC}"
                exit 1
        fi
elif [ "$INPUT" = no ]; then
        echo -e "${BYELLOW}Not compressing${NC} ${BBLUE}$FOLDER${NC}${BYELLOW}...${NC} \n"
        echo -e "${BGREEN}Backup Completed!${NC}"
else
        echo -e "${BRED}Unrecognized input, exiting...${NC}"
        exit 1
fi
