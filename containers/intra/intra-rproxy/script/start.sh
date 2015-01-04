#!/bin/bash

NGINX_CONF_TEMPLATE=/etc/nginx/conf.d/default.conf.tmpl
NGINX_CONF=/etc/nginx/conf.d/default.conf

sed -e "s!SED_ADMIN_URL!http://${COREOS_PRIVATE_IPV4}:${ADMIN_PORT}!g" \
	< $NGINX_CONF_TEMPLATE > $NGINX_CONF

nginx -g 'daemon off;'
