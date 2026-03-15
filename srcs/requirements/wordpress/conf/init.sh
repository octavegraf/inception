#!/bin/bash
set -x

# Copy conf if not exist
test -f /var/www/wordpress/index.php || cp -r /usr/src/wordpress/* /var/www/wordpress/

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

sed -i "s#DB_NAME_PLACEHOLDER#${DB_NAME}#g" /var/www/wordpress/wp-config.php
sed -i "s#DB_USER_PLACEHOLDER#${DB_USER}#g" /var/www/wordpress/wp-config.php
sed -i "s#DB_PASSWORD_PLACEHOLDER#${DB_PASSWORD}#g" /var/www/wordpress/wp-config.php
sed -i "s#AUTH_KEY_PLACEHOLDER#${AUTH_KEY}#g" /var/www/wordpress/wp-config.php
sed -i "s#SECURE_AUTH_KEY_PLACEHOLDER#${SECURE_AUTH_KEY}#g" /var/www/wordpress/wp-config.php
sed -i "s#LOGGED_IN_KEY_PLACEHOLDER#${LOGGED_IN_KEY}#g" /var/www/wordpress/wp-config.php
sed -i "s#NONCE_KEY_PLACEHOLDER#${NONCE_KEY}#g" /var/www/wordpress/wp-config.php
sed -i "s#AUTH_SALT_PLACEHOLDER#${AUTH_SALT}#g" /var/www/wordpress/wp-config.php
sed -i "s#SECURE_AUTH_SALT_PLACEHOLDER#${SECURE_AUTH_SALT}#g" /var/www/wordpress/wp-config.php
sed -i "s#LOGGED_IN_SALT_PLACEHOLDER#${LOGGED_IN_SALT}#g" /var/www/wordpress/wp-config.php
sed -i "s#NONCE_SALT_PLACEHOLDER#${NONCE_SALT}#g" /var/www/wordpress/wp-config.php

sleep 10
exec php-fpm8.2 -F