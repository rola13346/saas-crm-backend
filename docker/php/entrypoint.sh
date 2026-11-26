#!/bin/sh
set -e
cd /var/www/html

OWNER_UID=$(stat -c %u .)
OWNER_GID=$(stat -c %g .)
if [ "$OWNER_UID" != "0" ]; then
  groupmod -o -g "$OWNER_GID" laravel
  usermod  -o -u "$OWNER_UID" laravel
fi

run() { su laravel -s /bin/sh -c "$*"; }

[ -f .env ]   || run "cp .env.example .env"
[ -d vendor ] || run "composer install"
grep -q '^APP_KEY=base64' .env || run "php artisan key:generate"
run "php artisan migrate --force"

exec php-fpm
