#!/bin/bash
#Installer for nodejs and npm

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


cd ~

sudo apt update && sudo apt upgrade -y

sudo apt install curl -y

curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs -y

echo -e "\n\n\nNode.js and npm has been installed\n\n\n"
