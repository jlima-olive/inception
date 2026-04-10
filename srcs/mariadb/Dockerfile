FROM debian:oldstable

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server 
RUN rm -rf /var/lib/mysql/*

COPY mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf

COPY mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

# Create the directory used for the MariaDB Unix socket
RUN mkdir -p /run/mysqld

RUN chown -R mysql:mysql /run/mysqld

RUN chown -R mysql:mysql /var/lib/mysql

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]