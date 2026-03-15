FROM debian:12-slim
# i use the slim version bcause it is lighter and faster to build

RUN apt update
RUN apt upgrade
RUN apt install -y wget php php-fpm php-mysql mariadb-client
# -y : yes to all questions

RUN wget https://wordpress.org/wordpress-6.9.2.tar.gz -P /usr/src
RUN cd /usr/src && tar -xzf wordpress-6.9.2.tar.gz && rm wordpress-6.9.2.tar.gz
RUN chown -R root:root /usr/src/wordpress

COPY conf/php.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY conf/wordpress.conf /usr/src/wordpress/wp-config.php

COPY conf/init.sh /init.sh
RUN chmod +x /init.sh
# RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html

CMD ["./init.sh"]