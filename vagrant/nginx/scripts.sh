echo "Updating Ubunutu OS"
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing Nginx"
sudo apt-get install Nginx -y

sudo cp /vagrant/nginx/new-server.local /etc/nginx/sites-available/
sudo mkdir -p /var/www/keys
sudo cp /vagrant/keys/* /var/www/keys/

sudo su -c "ln -s /etc/nginx/sites-available/new-server.local /etc/nginx/sites-enabled/new-server.local"
sudo cp /vagrant/nginx/new-server.local /etc/nginx/conf.d/

# sudo mkdir /var/www/new-server.cd local/logs/
sudo nginx -s reload

echo "Installing PHP"
sudo apt-get install php5 php5-cli php5-fpm -y

# restart nginx
sudo /etc/init.d/nginx restart