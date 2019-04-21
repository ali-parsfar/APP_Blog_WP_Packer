#!/bin/bash
sudo yum  update -y
#### make sure ssh is enabled
sudo systemctl enable ssh
sudo service sshd restart

#### install htppd 
sudo yum install -y httpd mc htop 
sudo cp /home/ec2-user/www/* /var/www/html/
ls -lthr /var/www/html/
sudo systemctl enable httpd

##### Install PHP 7.2
sudo amazon-linux-extras install -y php7.2

##### MariaDB ( mysql ) moved to Ansible 
#
##### install wp
cd /var/www/html
sudo wget http://wordpress.org/latest.tar.gz 
sudo tar -xzvf latest.tar.gz
sudo cp -r wordpress/* /var/www/html
sudo rm rf wordpress
sudo rm -f latest.tar.gz
sudo chmod -R apache:apache wp-content
sudo chmod 755 
sudo systemctl  httpd restart
