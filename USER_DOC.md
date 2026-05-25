- This file explains, in clear and simple terms, how an end user or administrator can:

## The services provided are:

### Mariadb

- MariaDB Server is one of the most popular open source relational databases. Mariadb was made to be an open source substitute tp MySQL and as such it was made to be accecible with MySQL commands.

### NGINX

- NGINX is a proxy/reverse proxy webserver meaning it can redirect and disperse requests between client and server allowing for effortless comunication between the two.

### Wordpress
 
- WordPress is a web content management system. Originally it was meant to be used to managed webblog sites but it has sense evolved into a more refined tool capable of designing and managing administrator functions.

## How to run the project

### make down

* Stops containers and removes containers, networks, volumes, and images created by up.
* By default, the only things removed are:
   - Containers for services defined in the Compose file.
   - Networks defined in the networks section of the Compose file.
   - The default network, if one is used.

## How to manage and run the project

### make stop

* Stops running containers without removing them. They can be started again with docker compose start.

### make start

* Starts existing containers for a service

### Accesssing

The website managed by the project can be accessed via the url https://jlima-so.42.fr

### Administration

- Administrator settings outside wordpress can be modified within the .env file included in srcs/.env
- Wordpress Administrator settings can be modified within https://jlima-so.42.fr/wp-admin page using the credentials that can be found within the .env file
- The services can be checked using the make ps command.