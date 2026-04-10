#!/bin/bash

set -e

until mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "SELECT 1;" >/dev/null 2>&1; do
	echo "Waiting for MariaDB..."
	sleep 1
done

if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo "Downloading WordPress..."

	cd /tmp
	wget https://wordpress.org/latest.tar.gz

	tar -xzf latest.tar.gz
	cp -a wordpress/. /var/www/html/

	# Remove temporary installation files
	rm -rf /tmp/latest.tar.gz /tmp/wordpress

	# Move to the WordPress directory to run WP-CLI commands
	cd /var/www/html

	# Generate the wp-config.php file with database connection settings
	wp config create \
		--allow-root \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="$MYSQL_HOST:3306" 
	
	# Install WordPress core and create the administrator account
	wp core install \
		--allow-root \
		--url="$DOMAIN_NAME" \
		--title="$WP_TITLE" \
		--admin_user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASSWORD" \
		--admin_email="$WP_ADMIN_EMAIL" \
		--skip-email

	# Create an additional WordPress user required by the subject
	wp user create "$WP_USER" "$WP_USER_EMAIL" \
		--allow-root \
		--role=author \
		--user_pass="$WP_USER_PASSWORD"
	
	echo "WordPress installed."
fi

echo "Starting WordPress..."

# Replace the shell with php-fpm and keep it in the foreground
# The -F option prevents php-fpm from running as a daemon, which is required in Docker
exec /usr/sbin/php-fpm8.2 -F
