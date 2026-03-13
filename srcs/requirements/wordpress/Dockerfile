FROM debian:12-slim
# i use the slim version bcause it is lighter and faster to build

RUN apt update
RUN apt upgrade
RUN apt install -y wget php php-fpm php-mysql mariadb-client
# -y : yes to all questions

RUN wget https://wordpress.org/wordpress-6.9.2.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.9.2.tar.gz && rm wordpress-6.9.2.tar.gz
RUN chown -R root:root /var/www/wordpress

# RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCALITY}/O=${SSL_ORGANIZATION}/OU=${SSL_ORGANIZATIONAL_UNIT}/CN=${DOMAIN}/UID=${UID}"

COPY conf/php.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY conf/wordpress.conf /var/www/wordpress/wp-config.php

COPY conf/init.sh /init.sh
RUN chmod +x /init.sh
# RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html

CMD ["./init.sh"]