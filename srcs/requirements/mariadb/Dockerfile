
FROM debian:bookworm

RUN apt update && \
	apt install -y mariadb-server &&\
	apt clean && rm -fr /var/lib/apt/lists/*

COPY conf/mariadb.cnf /etc/mysql/my.cnf
COPY tools/mariadb-init.sh /usr/local/bin/mariadb-init.sh


RUN chmod +x /usr/local/bin/mariadb-init.sh &&\
	mkdir -p /run/mysqld &&\
	chown -R mysql:mysql /run/mysqld

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/mariadb-init.sh" ]
