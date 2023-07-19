#!/bin/bash
#Installer for PHP8.2, Apache2, MySQL, Composer and phpmyadmin

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cd ~

sudo apt update && sudo apt upgrade -y

apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip git -y

curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

apt update

apt install apache2 -y
apt install php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-xml php8.2-xsl php8.2-zip php8.2-bz2 libapache2-mod-php8.2 -y
apt install mariadb-server mariadb-client -y

cd /usr/share

wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip

unzip phpmyadmin.zip

rm phpmyadmin.zip

mv phpMyAdmin-*-all-languages phpmyadmin

chmod -R 0755 phpmyadmin


printf "# phpMyAdmin Apache configuration

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
</Directory>

# Disallow web access to directories that don't need it
<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/lib>
    Require all denied
</Directory>" >> /etc/apache2/conf-available/phpmyadmin.conf

a2enconf phpmyadmin

systemctl reload apache2

mkdir /usr/share/phpmyadmin/tmp/

chown -R www-data:www-data /usr/share/phpmyadmin/tmp/

cd ~

curl -sS https://getcomposer.org/installer -o composer-setup.php

HASH=`curl -sS https://composer.github.io/installer.sig`

php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

rm composer-setup.php

echo -e "\n\n\nPHP, Apache2, MySQL, Composer and phpmyadmin has been installed.\nAt last enter the command 'mysql_secure_installation'.\nAt the first question press the Enter key. Next you will be asked if you want to switch to 'unix_socket_authentication', confirm this with 'n'.Then you will be asked if you want to change the root password which you confirm with an Enter\nand the rest that follow all confirm with Enter.\n\n\n"