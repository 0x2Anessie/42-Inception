#!/bin/sh

# Lancement temporaire de MariaDB pour l'initialisation
service mariadb start
sleep 5 # Petit délai pour s'assurer que le service est prêt

# Création de la base de données si elle n'existe pas
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

# Création de l'utilisateur s'il n'existe pas, avec le mdp défini dans le .env
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Attribution des privilèges à l'utilisateur sur la base
mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"

# Appliquer les changements
mariadb -e "FLUSH PRIVILEGES;"

# Arrêt du serveur lancé par "service"
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown


mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'