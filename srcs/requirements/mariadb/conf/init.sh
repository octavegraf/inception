#!/bin/bash
set -x

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
mysql -u root -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${SQL_USER}'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

touch /var/lib/mysql/.inception_init

mysqladmin -u root shutdown
sleep 2

exec mysqld --user=mysql