#!/bin/sh

# Télécharger WP-CLI (outil en ligne de commande pour WordPress)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Le rendre exécutable et l’installer
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Définir les permissions et propriété du dossier WordPress
cd /var/www/wordpress
chmod -R 755 /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

# Supprimer l’ancien fichier de config au cas où
rm /var/www/wordpress/wp-config.php

# Télécharger WordPress
wp core download --allow-root

# Générer wp-config.php avec les infos de base de donnee
wp core config --dbhost="mariadb:3306" \
    --dbname="$MYSQL_DB" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --allow-root
    #iciiiiii

# Installer WordPress (admin)
wp core install --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_NAME" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --allow-root

# Créer un utilisateur secondaire
wp user create "$WP_U_NAME" "$WP_U_EMAIL" \
    --user_pass="$WP_U_PASS" \
    --role="$WP_U_ROLE" \
    --allow-root

# Correction du port pour php-fpm (remplace le socket par un port)
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# Dossier runtime de php
mkdir -p /run/php

# Lancer php-fpm en foreground
/usr/sbin/php-fpm7.4 -F
