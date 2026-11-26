FROM php:8.5-fpm-bookworm

RUN groupadd -g 1000 laravel \
    && useradd -m -u 1000 -g laravel -s /bin/bash laravel

RUN apt-get update && apt-get install -y --no-install-recommends \
    git unzip libpq-dev \
    && docker-php-ext-install pdo_pgsql bcmath \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

RUN sed -i 's/^user = .*/user = laravel/; s/^group = .*/group = laravel/' \
    /usr/local/etc/php-fpm.d/www.conf

COPY docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["entrypoint.sh"]
