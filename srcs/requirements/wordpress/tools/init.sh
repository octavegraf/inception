#!/bin/bash
set -x

until (echo > /dev/tcp/mariadb/3306); do
  sleep 2
done

# Copy conf if not exist
test -f /var/www/wordpress/wp-config.php || cp -r /usr/src/wordpress/* /var/www/wordpress/
cp /usr/src/wordpress/wp-config.php /var/www/wordpress/

DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
AUTH_KEY=$(cat /run/secrets/auth_key)
SECURE_AUTH_KEY=$(cat /run/secrets/secure_auth_key)
LOGGED_IN_KEY=$(cat /run/secrets/logged_in_key)
NONCE_KEY=$(cat /run/secrets/nonce_key)
AUTH_SALT=$(cat /run/secrets/auth_salt)
SECURE_AUTH_SALT=$(cat /run/secrets/secure_auth_salt)
LOGGED_IN_SALT=$(cat /run/secrets/logged_in_salt)
NONCE_SALT=$(cat /run/secrets/nonce_salt)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)

export DB_NAME DB_HOST DB_USER DB_PASSWORD AUTH_KEY SECURE_AUTH_KEY LOGGED_IN_KEY NONCE_KEY AUTH_SALT SECURE_AUTH_SALT LOGGED_IN_SALT NONCE_SALT DOMAIN

# Using gettext instead of 
envsubst '$DB_NAME:$DB_HOST:$DB_USER:$DB_PASSWORD:$AUTH_KEY:$SECURE_AUTH_KEY:$LOGGED_IN_KEY:$NONCE_KEY:$AUTH_SALT:$SECURE_AUTH_SALT:$LOGGED_IN_SALT:$NONCE_SALT:$DOMAIN' < /usr/src/wordpress/wp-config.php > /var/www/wordpress/wp-config.php

cd /var/www/wordpress

wp core install --allow-root --url="${DOMAIN}" --title="${WP_SITE_TITLE}" --admin_user="${WP_ADMIN_USERNAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --path="/var/www/wordpress"

sleep 10
exec php-fpm8.2 -F