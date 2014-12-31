#!/bin/bash

NGINX_CONF_TEMPLATE=/etc/nginx/conf.d/default.conf.tmpl
NGINX_CONF=/etc/nginx/conf.d/default.conf

sed -e "s!SED_PORTFOLIO_URL!http://${PORTFOLIO_PORT_80_TCP_ADDR}!g" \
	-e "s!SED_BLOG_URL!http://${BLOG_PORT_80_TCP_ADDR}!g" \
	-e "s!SED_JPJOURNAL_URL!http://${JPJOURNAL_PORT_80_TCP_ADDR}!g" \
	< $NGINX_CONF_TEMPLATE > $NGINX_CONF

nginx -g 'daemon off;'
