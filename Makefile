

COMPOSE_FILE = ./srcs/docker-compose.yml
MARIADB_DIR = /home/${USER}/data/mariadb
WORDPRESS_DIR = /home/${USER}/data/wordpress

all: up

$(MARIADB_DIR):
	mkdir -p $(MARIADB_DIR)

$(WORDPRESS_DIR):
	mkdir -p $(WORDPRESS_DIR)


build: $(MARIADB_DIR) $(WORDPRESS_DIR)
	docker compose -f $(COMPOSE_FILE) build

up: build
	docker compose -f $(COMPOSE_FILE) up -d

down: 
	docker compose -f $(COMPOSE_FILE) down

clean:
	docker compose -f $(COMPOSE_FILE) -f $(COMPOSE_FILE) down --rmi all
del:
	sudo rm -fr /home/aid-bray/data

re: clean del all

.PHONY: all build up down clean re