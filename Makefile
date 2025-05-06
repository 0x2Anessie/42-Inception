# -------- COULEURS -------- #
CLASSIC	= \e[0m
BOLD	= \e[1m
GREEN  	= \e[32m
PURPLE 	= \e[38;2;211;54;130m

# -------------- VARIABLES -------------- #
DC = @docker-compose
D = @docker
WP_DATA_PATH = /home/acatusse/data/wordpress
DB_DATA_PATH = /home/acatusse/data/mariadb
DC_PATH = -f ./srcs/docker-compose.yml
MAKE = @make $(1) --no-print-directory -C
DCR = docker-compose -f srcs/docker-compose.yml

# -------------- VARIABLES -------------- #
all: create

create: build up
	@echo "\n$(BOLD)ʕっ•ᴥ•ʔっ━☆ﾟ. * ･ ｡ﾟ$(GREEN)EVERYTHING IS BUILT AND STARTED!\nYou can reach the website with the command $(PURPLE)make open$(GREEN) or by typing$(PURPLE) acatusse.42.fr$(GREEN)\nin the url bar !\n$(CLASSIC)"

# Construit les images Docker définies dans le docker-compose.yml
build:
	@echo "\n$(BOLD)$(PURPLE)BUILDING DOCKER IMAGES...$(CLASSIC)"
	@mkdir -p $(WP_DATA_PATH)
	@mkdir -p $(DB_DATA_PATH)
	$(DC) $(DC_PATH) build

# Lance les conteneurs à partir des images construites, crée le réseaux et les volumes si besoin
up:
	@echo "\n$(BOLD)$(PURPLE)STARTING CONTAINERS, VOLUMES AND NETWORK...$(CLASSIC)"
	$(DC) $(DC_PATH) up -d

# Arrête tous les conteneurs définis dans le docker-compose.yml et supprime les conteneurs et le reseau
down:
	@echo "\n$(BOLD)$(PURPLE)STOPPING AND DELETING CONTAINERS AND NETWORK...$(CLASSIC)"
	$(DC) $(DC_PATH) down
	@echo "\n$(BOLD)ʕっ•ᴥ•ʔっ━☆ﾟ. * ･ ｡ﾟ$(GREEN)CONTAINERS STOPPED AND DELETED, NETWORK DELETED!\n$(CLASSIC)"

# Arrête uniquement les conteneurs en cours d'exécution, sans les supprimer
stop:
	@echo "\n$(BOLD)$(PURPLE)STOPPING CONTAINERS...$(CLASSIC)"
	$(DC) $(DC_PATH) stop
	@echo "\n$(BOLD)ʕっ•ᴥ•ʔっ━☆ﾟ. * ･ ｡ﾟ$(GREEN)CONTAINERS STOPPED!\n$(CLASSIC)"

# Relance les conteneurs qui ont été arrêtés (stopped) précédemment
start:
	@echo "\n$(BOLD)$(PURPLE)RESTARTING CONTAINERS...$(CLASSIC)"
	$(DC) $(DC_PATH) start
	@echo "\n$(BOLD)ʕっ•ᴥ•ʔっ━☆ﾟ. * ･ ｡ﾟ$(GREEN)CONTAINERS RESTARTED FROM STOPPED STATE!\n$(CLASSIC)"

# Supprime les conteneurs, les volumes et le reseau
clean:
	@echo "\n$(BOLD)$(PURPLE)DELETING CONTAINERS, VOLUMES AND NETWORK...$(CLASSIC)"
	$(DCR) down -v --remove-orphans
	rm -rf $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	@echo "\n$(BOLD)ʕっ•ᴥ•ʔっ━☆ﾟ. * ･ ｡ﾟ$(GREEN)CONTAINERS, VOLUMES AND NETWORK REMOVED!\n$(CLASSIC)"

re: clean create

# Stoppe les conteneurs et supprime : les conteneurs, les volumes, et le réseau
prune: clean
	$(D) system prune -a --volumes -f
	@echo "\n$(BOLD)ʕっ•ᴥ•ʔっ━☆ﾟ. * ･ ｡ﾟ$(GREEN)FULL SYSTEM PRUNED: UNUSED IMAGES, CONTAINERS, NETWORKS & VOLUMES REMOVED!\n$(CLASSIC)"


# Ouvre mon site WordPress
open:
	@xdg-open https://acatusse.42.fr || open https://acatusse.42.fr

# Ouvre l'interface admin de WordPress
openadmin:
	@xdg-open https://acatusse.42.fr/wp-admin/ || open https://acatusse.42.fr/wp-admin/

.PHONY: all create up down stop start build clean re prune open openadmin