#!/bin/bash

echo "Adding repository..."
sudo add-apt-repository ppa:leaeasy/dde

echo "Updating reposiries..."
sudo apt update

echo "Downloading dependencies..."
sudo apt install dde dde-file-manager -y

echo "Installing theme..."
sudo apt install deepin-gtk-theme