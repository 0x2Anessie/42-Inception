# Crée l'image Docker à partir de l’image officielle debian:bullseye-slim
FROM debian:bullseye-slim

# Mise à jour des paquets et installation de WordPress
# installe php : le langage PHP (interpréteur de base)
#          php7.4-fpm : permet à un serveur web (NGINX) d’exécuter PHP
#          php-mysql : le module PHP pour communiquer avec MariaDB/MySQL
#          mariadb-client : pour que WordPress puisse interagir avec MariaDB pendant l’install
#          curl : pour télécharger des fichiers (WordPress par exemple)
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl php php7.4-fpm php-mysql mariadb-client

# Copie du script de configuration WordPress
COPY ./wordpress-conf.sh /

# Permission d'exécution
RUN chmod +x /wordpress-conf.sh

# Lancer le script au démarrage
ENTRYPOINT [ "/wordpress-conf.sh" ]