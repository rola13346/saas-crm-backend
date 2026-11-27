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

if [ "$1" = "php-fpm" ]; then
  [ -f .env ] || run "cp .env.example .env"
  [ -f vendor/autoload.php ] || run "composer install"
  grep -q '^APP_KEY=base64' .env || run "php artisan key:generate"
  run "php artisan migrate --force"
  exec php-fpm
fi

until [ -f vendor/autoload.php ] && grep -q '^APP_KEY=base64' .env 2>/dev/null; do
  echo "Waiting for app setup..."
  sleep 3
done
exec su laravel -s /bin/sh -c "exec $*"
