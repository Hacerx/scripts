#!/bin/bash

echo 'Killing pending process...'
sudo fuser -vki  /var/lib/dpkg/lock

echo 'Removing file that makes the error...'
sudo rm -f /var/lib/dpkg/lock

echo 'Reconfigure packages...'
sudo dpkg --configure -a

echo 'Update...'
sudo apt update && sudo apt upgrade -y

echo 'Remove corrupt packages'
sudo apt-get autoremove