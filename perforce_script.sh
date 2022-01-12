#!/bin/bash 

set -x
echo -n world
set +x                                                                                                                                            

function update_packages()
{
    wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -
    "echo 'deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list"
    "echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' | sudo tee -a /etc/apt/sources.list"
}


function update_packages()
{
    sudo apt-get install linuxbrew-wrapper
    sudo apt-get update -qq
    sudo apt-get install helix-p4d
    sudo apt-get install -y apt-transport-https
    sudo systemctl enable helix-p4dctl
    sudo systemctl start helix-p4dctl
}

#***********************************************************************************
#	P4 Commands
#***********************************************************************************
function install_mandatories()
{
    p4 info
    p4 branches
    p4 -V
    p4 -h
    p4 -size

}
