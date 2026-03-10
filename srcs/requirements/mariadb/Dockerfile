FROM debian:12-slim
# i use the slim version bcause it is lighter and faster to build

ARG DB_NAME

RUN apt update
RUN apt upgrade
RUN apt install -y mariadb-server
# -y : yes to all questions

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init.sh /init.sh

CMD ["./init.sh"]