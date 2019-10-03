#!/bin/bash

echo "Adding Atom repo..."
sudo sh -c 'echo -e "[Atom]\nname=Atom Editor\nbaseurl=https://packagecloud.io/AtomEditor/atom/el/7/\$basearch\nenabled=1\ntype=rpm-md\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey" > /etc/zypp/repos.d/atom.repo'
echo "Adding openSuse repo..."
sudo sh -c 'echo -e "[OpenSUSE-15-OSS]\nname=OpenSUSE-15-OSS\nenabled=1\nbaseurl=http://download.opensuse.org/distribution/leap/15.0/repo/oss/\ntype=rpm-md" > /etc/zypp/repos.d/opensuse.repo
"Update repos..."
sudo zypper --gpg-auto-import-keys refresh

echo "Installing atom..."
zypper install atom

echo "Installing vlc..."
sudo zypper ar https://download.videolan.org/pub/vlc/SuSE/15 VLC

sudo zypper mr -r VLC

sudo zypper in vlc

sudo zypper install nano