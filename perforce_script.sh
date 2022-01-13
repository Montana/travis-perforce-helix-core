#!/bin/sh

set -x 
set -xe 

# Get the latest package lists

sudo apt-get update

# Get DEB files

wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -
echo 'deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list"
echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' | sudo tee -a /etc/apt/sources.list"

# Install from Repo

sudo apt-get install linuxbrew-wrapper
sudo apt-get update -qq
sudo apt-get install helix-p4d
sudo apt-get install -y apt-transport-https
sudo systemctl enable helix-p4dctl
sudo systemctl start helix-p4dctl

# Run P4 

p4 info

# Exit the script

exit 0
