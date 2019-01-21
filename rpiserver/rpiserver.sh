#!/bin/bash

#Static ip
echo "Settting IP static..."
sudo echo "#static ip configuration

interface eth0
static ip_address=192.168.1.155/24
static routers=192.168.1.1
static domain_name_servers=192.168.1.1" >> /etc/dhcpcd.conf

echo "Adding alias..."
sudo echo "
alias temp='/opt/vc/bin/vcgencmd measure_temp'
alias space='df -h'" >> .bashrc

#install something
echo "Installing some packages"
sudo apt-get update && sudo apt-get upgrade
sudo apt install ntfs-3g mysql-server build-essential php7.0-xml  -y

#apache server install
echo "Installing apache server..."
sudo apt-get install apache2 php7.0 php7.0-mysql -y
sudo chown www-data:www-data /var/www/html
sudo chmod -R 775 /var/www
sudo usermod -a -G www-data pi

#install plex
echo "Installing plex server..."
sudo apt-get install apt-transport-https 
wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key | sudo apt-key add -
echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list
sudo apt-get update
sudo apt-get install -t jessie plexmediaserver -y
sudo nano /etc/default/plexmediaserver.prev
sudo replace "PLEX_MEDIA_SERVER_USER=plex" "PLEX_MEDIA_SERVER_USER=pi" -- /etc/default/plexmediaserver.prev
#echo "Restart Plex Server"
sudo service plexmediaserver restart

#hdd from media
#sudo chmod 777 /media/pi
#sudo service plexmediaserver stop
#sudo addgroup plex pi
#sudo addgroup pi plex
#sudo chown -R plex:plex /media/pi/yourHDDname
#sudo service plexmediaserver start

#install deluge-web
echo "Installing deluge..."
sudo apt-get install deluged python-mako deluge-web -y
echo "Add deluge to start at boot"
sudo replace "exit 0" "sudo -u pi /usr/bin/python /usr/bin/deluge-web" -- /etc/rc.local
sudo echo "exit 0" >> /etc/rc.local

#install phpBB forum
sudo apt-get -y install mysql-server mysql-client php7.0-gd imagemagick unzip
sudo mysqladmin create phpBB
sudo mysql -Bse "create user 'pi'@'localhost' identified by 'password';"
sudo mysql -Bse "grant all privileges on \`phpBB\`.* to 'pi'@'localhost';"
sudo mysqladmin flush-privileges
wget https://www.phpbb.com/files/release/phpBB-3.2.3.zip
unzip phpBB-3.2.3.zip
cd /var/www/html/
mkdir foro
cd /home/pi
sudo cp -R phpBB3/* /var/www/html/foro/
sudo usermod -aG www-data pi
sudo chown -R www-data:www-data /var/www/html/foro/
cd /var/www/html/foro/
sudo chmod 660 images/avatars/upload/ config.php
sudo chmod 770 store/ cache/ files/

echo "Everything was installed"
echo "The system is going to reboot in 1 minute"
sudo shutdown -r +1
