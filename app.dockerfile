# dev
#FROM php:7.0.4-fpm

#RUN apt-get update && apt-get install -y libmcrypt-dev \
        #mysql-client libmagickwand-dev --no-install-recommends \
        #&& pecl install imagick \
        #&& docker-php-ext-enable imagick \
        #&& docker-php-ext-install mcrypt pdo_mysql

# prod
FROM shakyshane/laravel-php:latest

COPY composer.lock composer.json /var/www/

COPY database /var/www/database

WORKDIR /var/www

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && php composer.phar install --no-dev --no-scripts \
    && rm composer.phar

COPY . /var/www

RUN chown -R www-data:www-data \
        /var/www/storage \
        /var/www/bootstrap/cache

RUN php artisan optimize
