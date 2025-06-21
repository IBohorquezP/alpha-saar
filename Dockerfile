FROM php:5.6-fpm-alpine

# Update packages and install necessary PHP extensions
RUN apk update \
    apk add \
    php5.6-mcrypt \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
                                   --with-png-dir=/usr/include/ --enable-gd-native-ttf 
                                    
# Configuración de directorio de trabajo
WORKDIR /var/www

# Copiar archivos de la aplicación
COPY . /var/www

# Configurar permisos de las carpetas necesarias
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Configurar opcache para optimización en producción
RUN docker-php-ext-enable opcache

# Exponer el puerto
EXPOSE 9000

# Comando para correr PHP-FPM
CMD ["php-fpm"]
