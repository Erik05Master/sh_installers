#!/bin/bash
#Installer for .NET7

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


cd ~

sudo apt update && sudo apt upgrade -y

wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0

sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0

sudo apt-get install -y dotnet-runtime-7.0

echo -e "\n\n\n.NET7, SDK and Runtime is installed.\n\n\n"