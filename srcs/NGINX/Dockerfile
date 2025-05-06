FROM debian:bullseye-slim

# Installation des dependances
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl

# Génération du certificat SSL auto-signé
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=PACA/L=NICE/O=42/OU=42/CN=acatusse.42.fr/UID=super_user"

# Copie du fichier de configuration NGINX
COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

# Création du dossier WordPress (pointé depuis nginx.conf)
RUN mkdir -p /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress

# Exposition du port HTTPS
EXPOSE 443

# Lancement de NGINX (processus principal)
CMD ["nginx", "-g", "daemon off;"]  