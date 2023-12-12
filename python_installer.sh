#!/bin/bash
#Installer for Python3.12 and pip

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


cd ~

sudo apt update && sudo apt upgrade -y

sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y

wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz

tar -xf Python-3.12.*.tgz

cd Python-3.12.*/

./configure --enable-optimizations

make

sudo make altinstall

cd ~

wget https://bootstrap.pypa.io/get-pip.py

python3.12 get-pip.py

python3.12 --version

rm -r Python-3.12.*/ Python-3.12.*.tgz get-pip.py

echo -e "\n\n\nPython3.12 and pip has been installed.\n\n\n"
