#!/bin/sh

set -e
set -x

rsync -r . core@genkisugimoto.com:/home/core/
ssh core@genkisugimoto.com ./run.sh
