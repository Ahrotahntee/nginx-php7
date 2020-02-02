FROM alpine:latest

RUN apk add --no-cache --update curl nginx php-fpm && mkdir -p /run/nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD php-fpm.conf /etc/php7/php-fpm.d/www.conf
RUN rm -f /etc/nginx/conf.d/*.conf
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

HEALTHCHECK CMD curl --fail http://localhost/_ping
ENTRYPOINT ["/entrypoint.sh"]
