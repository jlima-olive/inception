FROM debian:oldstable

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y php8.2 php8.2-fpm php8.2-mysql mariadb-client curl wget tar ca-certificates

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN chmod +x wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY init_wp.sh /usr/local/bin/init_wp.sh

RUN chmod +x /usr/local/bin/init_wp.sh

# Create the directory used for the PHP-FPM socket
RUN mkdir -p /run/php
# Create the WordPress installation directory if it does not exist
RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /run/php
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/init_wp.sh"]