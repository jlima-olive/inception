NAME = inception
COMPOSE = docker compose -f docker-compose.yml

DATA_PATH = ~/data
DB_PATH = $(DATA_PATH)/mariadb
WP_PATH = $(DATA_PATH)/wordpress
DOMAIN = $$(cat .env | grep DOMAIN_NAME | awk -F= '{printf $$2}')
PREVDOMAIN = $$(cat ../.env | grep DOMAIN_NAME | awk -F= '{printf $$2}')

all: up

up: host create_dirs
	$(COMPOSE) up --build

host: .env
	(cat /etc/hosts | grep $(DOMAIN)) || (sudo sh -c "echo 127.0.0.1 $(DOMAIN) www.$(DOMAIN) >> /etc/hosts")

.env:
	wget https://raw.githubusercontent.com/jlima-olive/inception/refs/heads/main/.env

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart: down up

build:
	$(COMPOSE) build

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

create_dirs:
	sudo mkdir -p $(DB_PATH)
	sudo mkdir -p $(WP_PATH)

clean:
	docker stop $$(docker ps | awk 'NR>1 {printf $$1 " "}') || true

fclean: clean down
	sudo rm -rf $(DB_PATH)/*
	sudo rm -rf $(WP_PATH)/*
	docker system prune -a -f --volumes

re: fclean up

.PHONY: all up down start stop restart build logs ps create_dirs fclean re host