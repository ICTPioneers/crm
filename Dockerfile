FROM php:8.1.27-apache

USER root

#: install imap extension
RUN apt-get update && \
    apt-get install -y \
        libc-client-dev libkrb5-dev && \
    rm -r /var/lib/apt/lists/*
    
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-install -j$(nproc) imap

RUN docker-php-ext-install mysqli

#: configs
COPY ./__docker/php.ini /usr/local/etc/php/php.ini

WORKDIR /var/www/html/


COPY . .

RUN chmod -R 777 /var/www/html