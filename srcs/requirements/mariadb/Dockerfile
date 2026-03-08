FROM debian:12-slim
# i use the slim version bcause it is lighter and faster to build

ARG DB_NAME

RUN apt update
RUN apt upgrade
RUN apt install -y mariadb-server
# -y : yes to all questions

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

# RUN service mariadb start;
# RUN mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
# RUN mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# RUN mysql -e "GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
# RUN mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
# RUN mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
# RUN mysql -e "FLUSH PRIVILEGES;"
# RUN mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
# RUN exec mysqld_safe