#!/bin/bash
sudo yum  update -y
#### make sure ssh is enabled
sudo systemctl enable sshd
sudo systemctl restart sshd

#### install htppd
sudo yum install -y httpd mc htop
sudo cp /home/ec2-user/www/* /var/www/html/
sudo ls -lthr /var/www/html/
sudo systemctl enable httpd

##### Install PHP 7.2
sudo amazon-linux-extras install -y php7.2
php -v
##### MariaDB ( mysql ) moved to Ansible
#
##### install wp
cd /var/www/html
sudo wget http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz
sudo cp -r wordpress/* /var/www/html
sudo rm -rf wordpress
sudo rm -f latest.tar.gz
sudo chown -R apache:apache /var/www/html/*
sudo chmod 755 /var/www/html/*
sudo systemctl  restart httpd

