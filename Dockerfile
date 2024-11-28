FROM nginx:latest

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-xml \
    php-curl \
    php-mbstring \
    php-zip \
    php-gd \
    php-soap \
    php-intl \
    curl \
    unzip \
    && apt-get clean

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

COPY ./wordpress /var/www/html

RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80

CMD service php7.4-fpm start && nginx -g "daemon off;"
