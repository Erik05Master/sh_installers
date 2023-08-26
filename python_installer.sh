#!/bin/bash
#Installer for Python3.11 and pip

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


cd ~

sudo apt update && sudo apt upgrade -y

sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y

wget https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz

tar -xf Python-3.11.*.tgz

cd Python-3.11.*/

./configure --enable-optimizations

make

sudo make altinstall

cd ~

wget https://bootstrap.pypa.io/get-pip.py

python3.11 get-pip.py

python3.11 --version

rm -r Python-3.11.*/ Python-3.11.*.tgz get-pip.py

echo -e "\n\n\nPython3.11 and pip has been installed.\n\n\n"
