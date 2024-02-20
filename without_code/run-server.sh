#!/bin/bash

SQL_DB_TYPE=${SQL_DB_TYPE:-mariadb};
SQL_DB_HOST=${SQL_DB_HOST:-localhost};
SQL_DB_NAME=${SQL_DB_NAME:-moodledb};
SQL_DB_USER=${SQL_DB_USER:-moodle};
SQL_DB_PASS=${SQL_DB_PASS:-moodle};
HTTP_PROTO=${HTTP_PROTO:-http};
HTTP_URL=${HTTP_URL:-localhost};

chown -R www-data:www-data /var/www/html/appserver 
chmod -R 755 /var/www/html/* 

sed -i "s/>dbtype.*/>dbtype    = '${SQL_DB_TYPE}';/g" /var/www/html/appserver/config.php 
sed -i "s/>dblibrary.*/>dblibrary = 'native';/g" /var/www/html/appserver/config.php 
sed -i "s/>dbhost.*/>dbhost = '${SQL_DB_HOST}';/g" /var/www/html/appserver/config.php 
sed -i "s/>dbname.*/>dbname = '${SQL_DB_NAME}';/g" /var/www/html/appserver/config.php 
sed -i "s/>dbuser.*/>dbuser = '${SQL_DB_USER}';/g" /var/www/html/appserver/config.php 
sed -i "s/>dbpass.*/>dbpass = '${SQL_DB_PASS}';/g" /var/www/html/appserver/config.php 
sed -i "s/>wwwroot.*/>wwwroot = '${HTTP_PROTO}:\/\/${HTTP_URL}';/g" /var/www/html/appserver/config.php 
sed -i "s/>dataroot.*/>dataroot = '\/var\/www\/html\/appserverdata';/g" /var/www/html/appserver/config.php 

service php8.1-fpm start
service nginx start

tail -f /var/log/nginx/*.log &
wait $!
