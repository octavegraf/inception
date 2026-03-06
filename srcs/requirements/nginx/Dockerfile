FROM debian:bookworm-slim

RUN apt update
RUN apt upgrade
RUN apt install -y nginx openssl
# -y : yes to all questions

RUN mkdir -p /etc/nginx/ssl /var/run/nginx
# -p : create parent directories if they don't exist

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=Île-de-France/L=Paris/O=42/OU=42/CN=ocgraf.42.fr/UID=ocgraf"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]