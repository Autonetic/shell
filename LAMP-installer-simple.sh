#!/bin/sh

YELLOW='\033[1;33'
GREEN='\033[1;32m'
BGREEN='\033[1;32m'
RED='\033[1;31m'
BPURPLE='\033[1;35m'
NC='\033[0m'

installPHP () {
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt install apache2 apache2-utils
	sudo systemctl start apache2
	sudo systemctl enable apache2
	sudo ufw allow 80/tcp
	sudo ufw reload
	sudo apt install -y mariadb-server mariadb-client 
	sudo systemctl start mariadb
	sudo systemctl enable mariadb
	sudo mysql_secure_installation
	sudo mysql -u root -p
	sudo apt install -y php8.1 php8.1-mysql php-common php8.1-cli php8.1-cgi php8.1-oauth php-zip php-xml php-mbstring php-gd php-curl 
	sudo a2enmod php8.1
	sudo a2dismod php8.1
	sudo apt install php8.1-fpm
	sudo a2enmod proxy_fcgi setenvif
	sudo a2enconf php8.1-fpm
	sudo systemctl enable php8.1-fpm
	sudo systemctl restart apache2
}
echo "\033[1;35m+-----------------------------------------+\033[0m"
echo "\033[1;35m|\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\|\033[0m"
echo "\033[1;35m|-----------=[ \033[0m\033[1;32mLAMP Installer.\033[0m\033[1;35m ]=---------|\033[0m"
echo "\033[1;35m|-------------=(\033[0;35m^C to quit\033[1;35m)=--------------|\033[0m"
echo "\033[1;35m|/\/\/\/\/\/\033[0m\033[1;33mCoded@ Autonetix.co\033[0m\033[1;35m/\/\/\/\/\/|\033[0m"
echo "\033[1;35m+-----------------------------------------+\033[0m"	
if installPHP
then 
	wait
	echo "${GREEN}LAMP has been installed!${NC}"
else
	echo "${RED}ERROR!${NC}${YELLOW}Something went wrong!${NC}"
fi
