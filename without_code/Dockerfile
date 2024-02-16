FROM ubuntu:22.04
LABEL maintainer Alex Ivanov <grig.alste@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive 

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    echo "tzdata tzdata/Zones/Europe select Berlin" | debconf-set-selections && \
    echo "tzdata tzdata/Zones/Etc select UTC" | debconf-set-selections && \
    apt-get update -y && \
    apt-get install -y nginx php-fpm php-common php-mysql \
    php-gmp php-curl php-intl php-mbstring php-soap php-xmlrpc php-gd \
    php-xml php-cli php-zip curl cron mariadb-client && \
    sed -i 's/memory_limit = .*/memory_limit = 256M/g' /etc/php/8.1/fpm/php.ini && \
    sed -i 's/^;cgi.fix_pathinfo/cgi.fix_pathinfo/g' /etc/php/8.1/fpm/php.ini && \
    sed -i 's/upload_max_filesize = .*/upload_max_filesize = 90M/g' /etc/php/8.1/fpm/php.ini && \
    sed -i 's/max_execution_time = .*/max_execution_time = 330/g' /etc/php/8.1/fpm/php.ini && \
    sed -i 's/^;date.timezone =.*/date.timezone = Europe\/Berlin/g' /etc/php/8.1/fpm/php.ini && \
    sed -i 's/^;max_input_vars =.*/max_input_vars = 6000/g' /etc/php/8.1/fpm/php.ini && \
    rm -f /etc/nginx/sites-enabled/default && \
    service nginx stop && \
    service php8.1-fpm stop && \
    rm -rf /var/lib/apt/lists/*

COPY ./appserver.conf /etc/nginx/conf.d/appserver.conf
COPY ./run-server.sh /run-server.sh

RUN mkdir -p /var/www/html/appserver /var/www/html/appserverdata && \
    chown www-data:www-data /var/www/html/appserverdata && \
    chmod a+x /run-server.sh

EXPOSE 8080

VOLUME  /var/www/html/appserver

ENTRYPOINT ["/run-server.sh"]