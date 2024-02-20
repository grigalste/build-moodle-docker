#!/bin/bash

set -x

SQL_DB_TYPE=${SQL_DB_TYPE:-mariadb};
SQL_DB_HOST=${SQL_DB_HOST:-localhost};
SQL_DB_NAME=${SQL_DB_NAME:-db};
SQL_DB_USER=${SQL_DB_USER:-user};
SQL_DB_PASS=${SQL_DB_PASS:-password};
HTTP_PROTO=${HTTP_PROTO:-http};
HTTP_URL=${HTTP_URL:-localhost};
USER_NAME=${USER_NAME:-user};
USER_PASS=${USER_PASS:-password};
USER_EMAIL=${USER_EMAIL:-example@example.local};

chown -R www-data:www-data /var/www/html/appserver ;
chmod -R 755 /var/www/html/* ;

if [ -f "/run.sh" ]; then
    chmod a+x /run.sh ;
    source /run.sh 2>&1 /var/log/run-script.log &
else
    echo "Script '/run.sh' is missing!";
fi

service php8.1-fpm start
service nginx start

cat /var/log/run-script.log
tail -f /var/log/nginx/*.log &
wait $!
