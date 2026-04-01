#!/bin/bash

service mariadb start
sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Restart mariadb with new config in the background to keep the container running
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'