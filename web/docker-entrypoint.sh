#!/usr/bin/sh

openssl req -nodes -new -x509 \
  -keyout /etc/nginx/conf.d/client.key \
  -out /etc/nginx/conf.d/client.pem \
  -subj "/C=BE/ST=/L=/O=CN=headbang.re"

nginx -g "daemon off;"
