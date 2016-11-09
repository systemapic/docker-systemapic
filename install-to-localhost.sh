#!/bin/bash

# get working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

clear
echo ""
echo "====================================================="
echo "====== Welcome to Mapic localhost installation ======"
echo "====================================================="
echo ""
echo "Installing to localhost:"
echo "------------------------"
echo ""
echo "# Current working directory: $DIR"
echo "# Downloading code...\n"

# init mapic/mapic submodule
cd $DIR 
git submodule init
git submodule update --recursive --remote
git submodule foreach --recursive git checkout master

# init mapic/mile submodule
cd $DIR/modules/mile
git submodule init
git submodule update --recursive --remote

# init mapic/engine submodule
cd $DIR/modules/engine
git submodule init
git submodule update --recursive --remote

# init mapic/mapic.js submodule
cd $DIR/modules/mapic.js
git submodule init
git submodule update --recursive --remote

# init mapic/sdk submodule
cd $DIR/modules/sdk
git submodule init
git submodule update --recursive --remote



echo "# Creating SSL certficate..."
docker run --rm -it --name openssl \
  -v $DIR/config/loclahost:/certs \
  wallies/openssl \
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/ssl_certificate.key -out /certs/ssl_certificate.pem -subj "/C=NO/ST=Oslo/L=Oslo/O=Mapic/OU=IT Department/CN=localhost"

export MAPIC_DOMAIN=localhost

# update config
echo "# Updating configuration..."
cd $DIR/scripts
node update-configs.js

echo "# Creating storage containers..."
cd $DIR/docker/compose/
sh create-storage-containers.sh

echo "# Starting Mapic server..."
sh start-containers.sh
# cd $DIR
# ./restart-mapic.sh

