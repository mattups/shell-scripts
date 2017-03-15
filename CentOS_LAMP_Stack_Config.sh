#!/bin/bash
# LAMP Stack installation script for CentOS 7
# Remember to chmod +x on this file to make it executable!

echo -e "\e[1;4;36m<-------------Starting!----------->\e[0m"
echo -e "\e[1;4;36m<-------------Updating-System!----------->\e[0m"
sudo yum update

# Installing MySQL
wget http://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
sudo yum -y localinstall mysql57-community-release-el7-9.noarch.rpm
sudo yum update
sudo yum -y install mysql-server

sudo systemctl start mysqld
sudo systemctl enable mysqld.service
sudo systemctl status mysqld
echo -e "\e[1;4;36m<------------MySQL-Installed!----------->\e[0m"

# Get MySQL temporary root password
echo -e "\e[1;4;36m<------------MySQL-tempPasswd----------->\e[0m"
grep 'temporary password' /var/log/mysqld.log | awk '{ print $NF }'
echo -e "\e[1;4;36m<------------MySQL-tempPasswd----------->\e[0m"

# Configuring MySQl
sudo mysql_secure_installation

# Installing Apache HTTP Server
sudo yum -y install httpd
sudo systemctl start httpd
sudo systemctl enable httpd.service
sudo systemctl status httpd
echo -e "\e[1;4;36m<------------Apache-HTTP-Server-Installed!----------->\e[0m"

# Installing PHP
sudo yum -y install php php-mysql
echo -e "\e[1;4;36m<------------PHP-Installed!----------->\e[0m"

# Updating system
sudo yum update
echo -e "\e[1;4;36m<------------System-Update-Complete!----------->\e[0m"

# Restarting httpd
sudo systemctl restart httpd
echo -e "\e[1;4;36m<------------Done!------------>\e[0m"
