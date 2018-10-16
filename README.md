# VagrantSetup

All folder will be here cd /VagrantSetup -> mkdir projectFolder

All steps should defind in scripts.sh

Apache, PHP, Mysql
	
	change in Settings.yaml

	script_file: apache/scripts.sh


Nginx, PHP
	
	change in Settings.yaml

	script_file: nginx/scripts.sh

	To activate ssl import and activate the certificate on your system

	/vagrant/keys > domain certificate


To run the vagrant:

	cd VagrantSetup/vagrant

	> vagrant up

To destroy the vagrant:

	> vagrant destroy

To ssh into vagrant 
	
	> vagrant ssh

To shutdown vagrant 
	
	> vagrant halt