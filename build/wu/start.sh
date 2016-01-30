#!/bin/bash

# copy config file
cd /var/www/wu
mkdir -p config
cp /systemapic/config/wu-config.js config/server-config.js

# start server
./server.sh