
echo "Updating Ubunutu OS"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing Apache"
sudo apt-get install apache2 apache2-dev -y

echo "installing PHP"
sudo apt-get install php5 php5-dev php5-cli libapache2-mod-php5 -y

echo "Installing php extensions"
sudo apt-get install curl php5-curl php5-mcrypt php5-mysql php5-xdebug php5-memcached php5-memcache dos2unix -y

echo "mysql setup config and install"
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server libapache2-mod-auth-mysql php5-mysql mysql-client libmysqlclient-dev libaprutil1-dbd-mysql vim php5-xsl memcached

echo "enable apache mods"
sudo a2enmod reqtimeout
sudo a2enmod dbd
sudo a2enmod headers
sudo a2enmod rewrite
sudo a2enmod authz_groupfile
sudo a2enmod proxy_http
sudo rm -f /etc/apache2/sites-enabled/000-default.conf
sudo service apache2 restart

echo "enable php modules"
sudo php5enmod mcrypt

echo "installing and enable modmyvhost"
wget https://mod-myvhost.googlecode.com/files/mod_myvhost-0.21.tar.gz
tar -xzf mod_myvhost-0.21.tar.gz
cd mod_myvhost-0.21
sudo make
sudo make install

sudo cp /vagrant/apache/myvhost.load /etc/apache2/mods-available/
sudo su -c "cat /vagrant/apache/hosts >> /etc/hosts"
sudo service apache2 restart
