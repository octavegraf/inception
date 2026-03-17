#!/bin/bash
set -x

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

cd /var/www/wordpress

wp config create --allow-root --dbname="${DB_NAME}" --dbuser="${DB_USER}" --dbpass="${DB_PASSWORD}" --dbhost="${DB_HOST}" --path="/var/www/wordpress"
wp core install --allow-root --url="https://ocgraf.42.fr" --title="${WP_SITE_TITLE}" --admin_user="${WP_ADMIN_USERNAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --path="/var/www/wordpress"

sleep 10
exec php-fpm8.2 -F