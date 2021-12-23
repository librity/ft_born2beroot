################################################################################
# lighttpd
################################################################################

# Install and enable lighttpd web server
apt-get install lighttpd
systemctl start lighttpd
# Run on startup
systemctl enable lighttpd

systemctl status lighttpd

# Allow http trafic (port 80)
ufw allow http
# http://b2br:80
# http://192.168.0.15:80

################################################################################
# MariaDB
################################################################################

# Install MariaDB (MySQL)
apt-get install mariadb-server
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb

# Run installation script with recomended configs:
mysql_secure_installation
# Switch to unix_socket authentication [Y/n]: Y
# Enter current password for root (enter for none): Enter
# Set root password? [Y/n]: Y
# New password: ROOT_PASSWORD
# Re-enter new password: ROOT_PASSWORD
# Remove anonymous users? [Y/n]: Y
# Disallow root login remotely? [Y/n]: Y
# Remove test database and access to it? [Y/n]:  Y
# Reload privilege tables now? [Y/n]:  Y

# Restart the db daemon
systemctl restart mariadb

# Login as root password and create
mysql -u root -p
"
CREATE DATABASE wordpress;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'ADMIN_PASSWORD';
GRANT ALL ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'ADMIN_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
"

################################################################################
# PHP
################################################################################

# Add php to apt's sources and save gpg key
apt-get install wget gnupg gnupg2 gnupg1 lsb-release ca-certificates apt-transport-https software-properties-common
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
# Install php 8.0
apt-get install php8.0
# Install php modules
apt-get install php-cgi php-common php-cli php-mysql php-gd php-imagick php-tidy php-xml php-xmlrpc php-fpm php7.3-recode
# Unistall apache
apt-get purge apache2

# Add PHP info view
nano /var/www/html/info.php
"
<?php
phpinfo();
?>
"

################################################################################
# Configure FastCGI
################################################################################

nano /etc/php/8.0/cgi/php.ini
"
cgi.fix_pathinfo=1
"
# PHP will listen for lighttpd on 127.0.0.1:9000
nano /etc/php/8.0/fpm/pool.d/www.conf
"
listen = 127.0.0.1:9000
"
# lighttpd will connect to PHP on 127.0.0.1:9000
nano /etc/lighttpd/conf-available/15-fastcgi-php.conf
"
((
#               "bin-path" => "/usr/bin/php-cgi",
#               "socket" => "/run/lighttpd/php.socket",
                "host" => "127.0.0.1",
                "port" => "9000",
                ...
))
"

# Enable fastcgi on lighttpd
lighty-enable-mod fastcgi
lighty-enable-mod fastcgi-php
# Restart lighttpd and PHP services
systemctl restart lighttpd
systemctl restart php8.0-fpm
# You should be able to open the PHP info page on your web browser:
# http://VM_IP/info.php

################################################################################
# WordPress
################################################################################

# Download, extract and move to server dir
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress/* /var/www/html/
rm -rf latest.tar.gz wordpress

# Configure Wordpress database
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
nano /var/www/html/wp-config.php
"
/** ... */
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'admin' );

/** MySQL database password */
define( 'DB_PASSWORD', 'ADMIN_PASSWORD' );
/** ... */
"
# Change folder and file permissions
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
# Restart lighttpd
systemctl restart lighttpd

# The Wordpress config menu should open on your browser
# http://VM_IP
