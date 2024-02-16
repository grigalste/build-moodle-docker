#!/bin/bash

MOODLE_VERSION=${MOODLE_VERSION:-MOODLE_403_STABLE};

docker build -t alste/php8.1-nocode:v0.1 .

apt-get install -y git ;
git clone -b ${MOODLE_VERSION} git://git.moodle.org/moodle.git ./moodle_git ;
rm -rf ./moodle_git/.* ./moodle_git/*.txt ;
cp -f ./moodle_git/config-dist.php ./moodle_git/config.php

#docker run -i -t -d -p 8080:8080 --name appserver --restart=always \
#    -v ${PWD}/./moodle_git:/var/www/html/appserver \
#    alste/php8.1-nocode:v0.1
