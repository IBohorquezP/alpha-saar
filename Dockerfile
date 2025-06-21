FROM php:5.6-fpm-alpine

# Update packages and install necessary PHP extensions
RUN apk update \
    && apk add --no-cache libjpeg-turbo-dev libpng-dev freetype-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
                                  --with-png-dir=/usr/include/ --enable-gd-native-ttf \
    && docker-php-ext-install -j$(nproc) gd mcrypt \
    && docker-php-ext-enable opcache # opcache is usually enabled after installation, but for simplicity, we can enable it here

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . /var/www

# Configure permissions for necessary folders
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose the port
EXPOSE 9000

# Command to run PHP-FPM
CMD ["php-fpm"]