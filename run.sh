#!/bin/bash

set -e
set -x

# Clean up
docker stop rproxy && docker rm rproxy
docker stop portfolio && docker rm portfolio
docker stop blog && docker rm blog
docker stop jpjournal && docker rm jpjournal

# Start portfolio container
docker run --name portfolio -v `pwd`/portfolio:/usr/share/nginx/html:ro -d nginx

# Start blog container
docker run --name blog -d genki/wordpress /start.sh

# Start japanese diary container
docker run --name jpjournal -v `pwd`/jp/journal:/usr/share/nginx/html:ro -d nginx

# Start rproxy
docker run --link portfolio:portfolio \
			--link blog:blog \
			--link jpjournal:jpjournal \
			--name rproxy \
			-v `pwd`/rproxy/script:/script \
			-v `pwd`/rproxy/conf.d:/etc/nginx/conf.d \
			-p 80:80 \
			-d \
			nginx /script/start.sh
