#!/usr/bin/bash
# Written by Montana Mendy Jan 12th, 2022. For Travis CI.
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

resolve_operation ()
{
  OPERATION="build"
  if [[ ("$TRAVIS_COMMIT_MESSAGE" == "release" ||  "$DEV_BRANCH" != "$RELEASE_BRANCH" ) && "$TRAVIS_EVENT_TYPE" != "pull_request"  && "$TRAVIS_BRANCH" == "$RELEASE_BRANCH" ]];
   then
     OPERATION="release"
   else
       if [ "$TRAVIS_EVENT_TYPE" != "pull_request" ] && [ "$TRAVIS_BRANCH" == "$DEV_BRANCH" ];
     then
       OPERATION="publish"
    fi
  fi
  echo -e "$OPERATION"
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

# If you want the Docker build, I'm going to be pushing this to DockerHub once I work more of the kinks out, should just be Montana/travis-perforce.

docker_build(){
  VERSION="$1"
  OPERATION="$2"

  validate_env_variable "DOCKER_IMAGE_NAME" "$FUNCNAME"
  validate_env_variable "VERSION" "$FUNCNAME"


  echo "Creating Perforce image from Montana ${DOCKER_IMAGE_NAME}:${VERSION}"
  docker build -t "${DOCKER_IMAGE_NAME}:${VERSION}" .

  if [[ "$OPERATION" == "publish" || "$OPERATION" == "release"  ]];
  then
      echo "Building for operation ${OPERATION}..."
      validate_env_variable "DOCKER_USERNAME" "$FUNCNAME"
      validate_env_variable "DOCKER_PASSWORD" "$FUNCNAME"
      echo "Login into docker..."
      echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

      if [ "$OPERATION" = "publish" ]
      then
          TIMESTAMP="$(date +%Y%m%d%H%M)"
          docker tag "${DOCKER_IMAGE_NAME}:${VERSION}" "${DOCKER_IMAGE_NAME}:${VERSION}-alpha"
          docker tag "${DOCKER_IMAGE_NAME}:${VERSION}" "${DOCKER_IMAGE_NAME}:${VERSION}-alpha-${TIMESTAMP}"
          echo "Docker pushing alpha ${TIMESTAMP}"
          docker push "${DOCKER_IMAGE_NAME}:${VERSION}-alpha"
          docker push "${DOCKER_IMAGE_NAME}:${VERSION}-alpha-${TIMESTAMP}"
      fi

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
