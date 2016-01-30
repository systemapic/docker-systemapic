#!/bin/bash

# copy config file
cd /var/www/pile
mkdir -p config
cp /systemapic/config/pile-config.js config/

# start server
pile-server.sh