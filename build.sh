#!/bin/sh

set -e
set -x

cd portfolio
git pull
npm install
bower install
gulp browserify
gulp sass
