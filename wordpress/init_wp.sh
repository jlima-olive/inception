#!/bin/bash

set -e

until mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SELECT 1;" >/dev/null 2>&1; do
	echo "Waiting for MariaDB..."
	sleep 1
done

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Downloading WordPress..."

	wget https://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	mv -a wordpress/. /var/www/html/
	rm -rf /tmp/latest.tar.gz

	cd /var/www/html

	wp config create \
		--allow-root \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="$MYSQL_HOST:3306" 
	wp core install \
		--allow-root \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email
	wp user create "$WP_USER" "$WP_USER_EMAIL" \
		--allow-root \
		--role=author \
		--user_pass="$WP_USER_PASSWORD"
	
	echo "WordPress installed."
fi

echo "Starting WordPress..."

exec /usr/sbin/php-fpm8.2 -F