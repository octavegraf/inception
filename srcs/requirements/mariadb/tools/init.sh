#!/bin/bash
set -x

# Read secrets from Docker Compose secret files
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
chown -R mysql:mysql /var/lib/mysql

mysqld --user=mysql --skip-networking &

while ! mysqladmin ping --silent 2>/dev/null; do
	sleep 1
done

mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"

touch /var/lib/mysql/.inception_init

mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
sleep 2

exec mysqld --user=mysql