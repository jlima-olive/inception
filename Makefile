WP_DATA = ./data/wordpress
DB_DATA = ./data/mariadb

all: up

up: build
	mkdir -p $(WP_DATA)
	mkdir -p $(DB_DATA)
	docker compose up -d

# stop the containers
down:
	docker compose down

# stop the containers
stop:
	docker compose stop

# start the containers
start:
	docker compose start

# build the containers
build:
	docker compose build

# clean the containers
# stop all running containers and remove them.
# remove all images, volumes and networks.
# remove the wordpress and mariadb data directories.
# the (|| true) is used to ignore the error if there are no containers running to prevent the make command from stopping.
clean:
	docker stop $$(docker ps -qa) || true
	docker rm $$(docker ps -qa) || true
	docker rmi -f $$(docker images -qa) || true
	docker volume rm $$(docker volume ls -q) || true
	docker network rm $$(docker network ls -q) || true

fclean: clean
	rm -rf $(WP_DATA) || true
	rm -rf $(DB_DATA) || true

# clean and start the containers
re: fclean all

# prune the containers: execute the clean target and remove all containers, images, volumes and networks from the system.
prune: fclean
	docker system prune -a --volumes -f