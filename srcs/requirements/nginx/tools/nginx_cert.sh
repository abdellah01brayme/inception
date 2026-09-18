#!/bin/sh

set -e

mkdir -p /etc/ssl/nginx/private &&\
mkdir -p /etc/ssl/nginx/certs

echo "genarate ssl..."

openssl req -x509 -nodes -days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/nginx/private/aid-bray.key \
	-out /etc/ssl/nginx/certs/aid-bray.crt \
	-subj "/C=MA/ST=RA/L=RA/O=42/OU=42/CN=aid-bray.42.fr"

nginx -t

echo "Starting Nginx in foreground..."

exec nginx -g "daemon off;"