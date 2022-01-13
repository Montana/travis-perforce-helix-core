#!/usr/bin/bash
# Written by Montana Mendy for Travis CI 
set -e

TRAVIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $TRAVIS_DIR/perforce_script.sh

assert_value ()
{
  value="$1"
  expectedValue="$2"
  if [ "$value" != "$expectedValue" ]
    then
      echo "'$value' is not the expected value for Perforce '$expectedValue'"
      exit 128
  fi
}

post_perforce_version_file(){

  validate_env_variable "RELEASE_BRANCH" "$FUNCNAME"
  validate_env_variable "REMOTE_NAME" "$FUNCNAME"
  validate_env_variable "POST_RELEASE_BRANCH" "$FUNCNAME"
  checkout_branch "${RELEASE_BRANCH}"
  VERSION="$(load_version_from_file)"
]

load_version_from_file(){
  VERSION="$(head -n 1 perforce.txt)"
  echo -e "$VERSION"
}

function get_prerequesites()
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

function run_p4()
{
    p4 info
    p4 branches
    p4 -V
    p4 -h
    p4 -size

}

if [ "$1" == "get_prerequesites" ];then
   wget -q https://package.perforce.com/perforce.pubkey -O - | sudo apt-key add -
   "echo 'deb http://package.perforce.com/apt/ubuntu precise release' | sudo tee -a /etc/apt/sources.list"
   "echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' | sudo tee -a /etc/apt/sources.list"
fi


if [ "$1" == "update_packages" ];then
    sudo apt-get install linuxbrew-wrapper
    sudo apt-get update -qq
    sudo apt-get install helix-p4d
    sudo apt-get install -y apt-transport-https
    sudo systemctl enable helix-p4dctl
    sudo systemctl start helix-p4dctl
fi


if [ "$1" == "run_p4" ];then
    p4 info
    p4 branches
    p4 -V
    p4 -h
    p4 -size
fi
