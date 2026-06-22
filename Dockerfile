FROM php:8.3-apache

COPY . /var/www/html/tcc/

RUN docker-php-ext-install mysqli pdo pdo_mysql