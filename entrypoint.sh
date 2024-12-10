#!/bin/sh

# Crear el directorio /run/nginx si no existe
mkdir -p /run/nginx

# Asegurar permisos adecuados
chmod 755 /run/nginx

# Ajustar permisos de los archivos montados
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Iniciar PHP-FPM en segundo plano
php-fpm &

# Iniciar Nginx en primer plano
nginx -g "daemon off;"
