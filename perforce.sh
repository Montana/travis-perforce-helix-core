#!/bin/bash
set -ex 
set checkjobs	

# Written by Montana Mendy Jan 12th, 2022. For Travis CI.

# Exporting Perforce settings like Journal.

export P4JOURNAL=/var/log/perforce/journal
export P4LOG=/var/log/perforce/p4err
export P4ROOT=/perforce_depot
export P4PORT=1666

p4 client -o > montana.txt
p4 client -i < montana2.txt

# You can run awk | sed to modify the client.

$dataf = "/tmp/montana31.txt";
if (! -f "$dataf") {
system("p4 describe 18291 > $dataf");
}
open(IN, "<$dataf") || die "Cannot open $dataf\n";

# It will change over to the "cl spec".

cl spec = p4.run("montana", "-o")[0]
cl name = cl spec[’Client’]
cl root = cl spec[’Root’]
puts "Ran user-client, output was ’client=#{cl name}’"
ret = p4.run("fstat, '//#"{cl.name}/montana..."

filesOnlyInLabel1 = label1filenames - label2filenames
filesOnlyInLabel1.each { |fname|
puts "Only in #{label1}: #{fname}"
}

	p4 verify -qu //...
	p4 verify -q #1,#1
	p4 verify -q #head,#head
    p4 purpose -u #montana//...

    # The Purpose flag limits deletion of forms, to implement a formal access control of jobs and labels.

case "$1" in
  start)
    log_action_begin_msg "Starting Perforce Server"
    daemon -u $p4user -- $p4start;
    ;;

  stop)
    log_action_begin_msg "Stopping Perforce Server"
    daemon -u $p4user -- $p4stop;
    ;;

  restart)
    stop
    start
    ;;

*)

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

install_jabba_on_linux () {
    unix_pre
}

install_jabba_on_osx () {
    unix_pre
    export JAVA_HOME="$HOME/.jabba/jdk/$ACTUAL_JDK/Contents/Home"
}

node_montanas_version_publish_release(){
  VERSION="$(node_load_version)"
  validate_env_variable "VERSION" "$FUNCNAME"
  if [ "$SKIP_RELEASE_PUBLISH" = "true" ]; then
    echo "Skipping publishing of the SDK artifacts Montana has"
    echo ""
  else
    validate_env_variable "NPM_TOKEN" "$FUNCNAME"
    cp travis/.npmrc $HOME/.npmrc
    echo "Publishing $TRAVIS_REPO_SLUG artifacts"
    npm publish
    echo ""
  fi
}

container_id() {
   __validate_input "${FUNCNAME[0]}" "$1"
   sudo docker inspect --format='{{.Id}}' "$1" 2>/dev/null
}

container_exists() {
   __validate_input "${FUNCNAME[0]}" "$1"
   __isnotempty "$(container_id "$1")"
}

post_perforce_version_file(){

  validate_env_variable "RELEASE_BRANCH" "$FUNCNAME"
  validate_env_variable "REMOTE_NAME" "$FUNCNAME"
  validate_env_variable "POST_RELEASE_BRANCH" "$FUNCNAME"
  checkout_branch "${RELEASE_BRANCH}"
  VERSION="$(load_version_from_file)"
}

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
