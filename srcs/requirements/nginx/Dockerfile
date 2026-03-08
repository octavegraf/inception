FROM debian:12-slim
# i use the slim version bcause it is lighter and faster to build

ARG DOMAIN
ARG UID
ARG SSL_COUNTRY
ARG SSL_STATE
ARG SSL_LOCALITY
ARG SSL_ORGANIZATION
ARG SSL_ORGANIZATIONAL_UNIT

RUN apt update
RUN apt upgrade
RUN apt install -y nginx openssl
# -y : yes to all questions

RUN mkdir -p /etc/nginx/ssl /var/run/nginx
# -p : create parent directories if they don't exist

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCALITY}/O=${SSL_ORGANIZATION}/OU=${SSL_ORGANIZATIONAL_UNIT}/CN=${DOMAIN}/UID=${UID}"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]