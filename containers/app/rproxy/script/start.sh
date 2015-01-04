#!/bin/bash

NGINX_CONF_TEMPLATE=/etc/nginx/conf.d/default.conf.tmpl
NGINX_CONF=/etc/nginx/conf.d/default.conf

sed -e "s!SED_PORTFOLIO_URL!http://${COREOS_PRIVATE_IPV4}:${PORTFOLIO_PORT}!g" \
	-e "s!SED_BLOG_URL!http://${COREOS_PRIVATE_IPV4}:${BLOG_PORT}!g" \
	-e "s!SED_JP_URL!http://${COREOS_PRIVATE_IPV4}:${JP_PORT}!g" \
	< $NGINX_CONF_TEMPLATE > $NGINX_CONF

nginx -g 'daemon off;'
