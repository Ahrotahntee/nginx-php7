#!/bin/sh
do_reload() {
    nginx -s reload
    killall -USR2 php-fpm7
}

do_stop() {
    killall -QUIT php-fpm7 nginx
}
cp /etc/hosts /srv/etc/hosts -f
cp /etc/resolv.conf /srv/etc/resolv.conf -f
echo 'Starting php-fpm7...'
php-fpm7 -F &
PHP_PID=$!
echo 'Starting nginx...'
nginx -g 'daemon off;' &
NGINX_PID=$!

trap do_stop SIGTERM
trap do_reload USR1

echo 'Ready!'
wait ${PHP_PID} ${NGINX_PID}
