

COMPOSE_DIR = srcs/
MARIADB_DIR = /HOME/${USER}/data/mariadb
WORDPRESS_DIR = /HOME/${USER}/data/wordpress

$(MARIADB_DIR):
	mkdir -p $(MARIADB_DIR)

$(WORDPRESS_DIR):
	mkdir -p $(WORDPRESS_DIR)

all: up

build: $(MARIADB_DIR) $(WORDPRESS_DIR)
	docker compose -p $(COMPOSE_DIR) build

up: build
	docker compose -p $(COMPOSE_DIR) up -d

down: 
	docker compose -p $(COMPOSE_DIR) down


clean:
	docker compose -p $(COMPOSE_DIR) -f $(COMPOSE_FILE) down --rmi all

re: down all

.PHONY: all build up down clean re