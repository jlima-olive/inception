#!/bin/bash

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing MariaDB database..."

	mariadb-install-db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal

	echo "Starting temporary MariaDB server..."
	mysqld_safe --datadir=/var/lib/mysql &
	pid="$!"

	echo "Waiting for MariaDB to start..."
	until mariadb-admin ping --silent; do
		sleep 1
	done

	echo "Creating database and user..."

	# Create the application database if it does not already exist
	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

	# Create the application user with access from any host
	mariadb -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

	# Grant the user full privileges on the application database
	mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

	# Set the root password for local administrative access
	mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	
	# Reload privilege tables so all changes take effect immediately
	mariadb -u root -e "FLUSH PRIVILEGES;"

	echo "Stopping temporary MariaDB server..."

	# Shut down the temporary MariaDB instance after initialization is complete
	mariadb-admin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

	# Wait for the background process to exit cleanly
	wait "$pid" || true
fi

echo "Starting MariaDB server..."

exec mysqld --user=mysql --datadir=/var/lib/mysql