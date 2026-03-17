#!/bin/bash

secrets=("DB_PASSWORD" "DB_ROOT_PASSWORD" "AUTH_KEY" "SECURE_AUTH_KEY" "LOGGED_IN_KEY" "NONCE_KEY" "AUTH_SALT" "SECURE_AUTH_SALT" "LOGGED_IN_SALT" "NONCE_SALT" "WP_ADMIN_PASSWORD")

# https://api.wordpress.org/secret-key/1.1/salt/

mkdir -p secrets

for arg in "${secrets[@]}"; do
	[ -f "secrets/$arg.txt" ] || touch "secrets/$arg.txt"
done