
FROM php:7.4.33-fpm-alpine

ARG user
ARG uid

RUN apk update && apk add \
    git \
    curl \
    zip \
    unzip \
    supervisor \
    openssl \
    shadow
# Add shadow package to install useradd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN docker-php-ext-install pdo 
    # && apk --no-cache install nodejs npm

# COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer


#USER root

#RUN chmod 777 -R /var/www/

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user
WORKDIR /var/www
USER $user