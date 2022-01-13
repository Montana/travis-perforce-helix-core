#!/bin/bash

echo "Running full test suite, Perforce Parallelism flags = '$MKPARARGS' \n"
set -xe

cd `dirname $0`
top=`pwd`

hostname || echo "No hostname command, env says $PERFORCE"
linuxbrew-wrapper
-qq
helix-p4d
-y apt-transport-https
helix-p4dctl
enable helix-p4dctl
start helix-p4dctl

p4 commands || geting "perforce started" 

p4 info
p4 branches
p4 -V
p4 -h
p4 -size

EOF
  
