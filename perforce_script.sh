#!/bin/bash 
set -x                                                                                                                                               "

echo "Travis CI/Perfore-Helix shell script beginning" 
  
wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -
deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list
deb https://packagecloud.io/github/git-lfs/debian/ jessie main' | sudo tee -a /etc/apt/sources.list
sudo apt-get install linuxbrew-wrapper
sudo apt-get update -qq
sudo apt-get install helix-p4d
sudo apt-get install -y apt-transport-https
sudo systemctl enable helix-p4dctl
sudo systemctl start helix-p4dctl
sudo /opt/perforce/sbin/configure-helix-p4d.sh -n perforce1 -p ssl:1666 -r /opt/perforce/servers/perforce1 -u montana -P REinforce --unicode
p4 info
p4 branches
p4 -V
p4 -h
p4 -size
