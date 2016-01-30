#!/bin/bash

# copy config file
cd /var/www/pile
mkdir -p /var/www/pile/config
cp /systemapic/config/pile-config.js /var/www/pile/config/pile-config.js

# start server
./pile-server.sh