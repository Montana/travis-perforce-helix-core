#!/bin/bash

echo 

"  ____            __                  _   _      _ _            ____                                 _   _____                _        ____ ___ 
 |  _ \ ___ _ __ / _| ___   ___ ___  | | | | ___| (_)_  __     / ___|___  _ __ ___    __ _ _ __   __| | |_   _| __ __ ___   _(_)___   / ___|_ _|
 | |_) / _ \ '__| |_ / _ \ / __/ _ \ | |_| |/ _ \ | \ \/ /____| |   / _ \| '__/ _ \  / _` | '_ \ / _` |   | || '__/ _` \ \ / / / __| | |    | | 
 |  __/  __/ |  |  _| (_) | (_|  __/ |  _  |  __/ | |>  <_____| |__| (_) | | |  __/ | (_| | | | | (_| |   | || | | (_| |\ V /| \__ \ | |___ | | 
 |_|   \___|_|  |_|  \___/ \___\___| |_| |_|\___|_|_/_/\_\     \____\___/|_|  \___|  \__,_|_| |_|\__,_|   |_||_|  \__,_| \_/ |_|___/  \____|___|
                                                                                                                                               "

 wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -"
 "echo 'deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list"
 "echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' | sudo tee -a /etc/apt/sources.list"
 "sudo apt-get install linuxbrew-wrapper"
 "sudo apt-get update -qq"
 "sudo apt-get install helix-p4d"
 "sudo apt-get install -y apt-transport-https"
 "sudo systemctl enable helix-p4dctl"
 "sudo systemctl start helix-p4dctl"
 "sudo /opt/perforce/sbin/configure-helix-p4d.sh -n perforce1 -p ssl:1666 -r /opt/perforce/servers/perforce1 -u montana -P REinforce --unicode"
 "p4 info"
 "p4 branches" 
 "p4 -V" 
 "p4 -h"
 "p4 -size" 
 "p4 -where'
