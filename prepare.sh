#!/bin/bash

MOODLE_VERSION=${MOODLE_VERSION:-MOODLE_403_STABLE};
REPO="";
NAME="";
VERSION="";

apt-get install -y git ;

git clone -b ${MOODLE_VERSION} git://git.moodle.org/moodle.git ./moodle_git ;

rm -rf ./moodle_git/.* ./moodle_git/*.txt ;
cp -f ./moodle_git/config-dist.php ./moodle_git/config.php

docker build -t ${REPO}/${NAME}:${VERSION} .
