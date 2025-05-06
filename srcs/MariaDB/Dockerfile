# Crée l'image Docker à partir de l’image officielle debian:bullseye-slim
FROM debian:bullseye-slim

# Mise à jour des paquets et installation de MariaDB
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server netcat

# Copie du script de configuration MariaDB
COPY ./mariadb-conf.sh /mariadb-conf.sh

# Rend le script exécutable
RUN chmod +x /mariadb-conf.sh

# Point d'entrée du conteneur
ENTRYPOINT [ "./mariadb-conf.sh" ]