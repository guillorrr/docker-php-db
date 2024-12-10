ARG PHP_VERSION

FROM php:${PHP_VERSION}

# Instalar Nginx
RUN apk add --no-cache \
    bash \
    curl \
    less \
    jq \
    git \
    openssh \
    unzip \
    zip \
    nginx \
    mariadb-client \
    libxml2-dev \
    && docker-php-ext-install mysqli \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /run/nginx

# Copiar configuraciones
COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /usr/local/etc/php/php.ini
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Permisos para el entrypoint
RUN chmod +x /usr/local/bin/entrypoint.sh

# Configurar directorio de trabajo
WORKDIR /var/www/html

# Set permissions for the WordPress directory
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80
EXPOSE 80

# Usar el entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]