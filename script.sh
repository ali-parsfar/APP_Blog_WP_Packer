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
sudo mv wp-config-sample.php wp-config.php
sed -i -e 's/database_name_here/blog_wp_tst/g' p-config.php
sed -i -e 's/username_here/blog/g' p-config.php
sed -i -e 's/password_here/Bl0g_wp_tst/g' p-config.php
sudo chown -R apache:apache /var/www/html/*
sudo chmod 755 /var/www/html/*
sudo systemctl  restart httpd

#####
# If /root/.my.cnf exists then it won't ask for root password
cat <<-EOF >  /root/.my.cnf 
[client]
user=root
password=P13@s3Ch@ng3m3
EOF
WPDB=blog_wp_tst
WPUSR=blog
WPPWD="Bl0g_wp_tst"

sudo mysql -e "CREATE DATABASE ${WPDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
sudo mysql -e "CREATE USER ${WPUSR}@localhost IDENTIFIED BY '${WPPWD}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${WPDB}.* TO '${WPUSR}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

######
