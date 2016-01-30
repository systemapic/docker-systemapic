#!/bin/bash

# copy config file
cd /var/www/wu
mkdir -p config
cp /systemapic/config/wu-config.js config/

# start server
server.sh