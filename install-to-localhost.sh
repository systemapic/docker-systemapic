#!/bin/bash

# get working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo $DIR

echo "Pulling Submodules --------------------------------->"

# init dockerize submodules
cd $DIR
git submodule init
git submodule update --recursive --remote
git submodule foreach --recursive git checkout master

# init mile submodules
cd $DIR/modules/mile
git submodule init
git submodule update --recursive --remote

# init engine submodules
cd $DIR/modules/engine
git submodule init
git submodule update --recursive --remote

# init mapic.js submodules
cd $DIR/modules/mapic.js
git submodule init
git submodule update --recursive --remote

# init sdk submodules
cd $DIR/modules/sdk
git submodule init
git submodule update --recursive --remote

echo "All Code Downloaded --------------------------------->"

echo "Adding SelfSigned SSL---------------------->"
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $DIR/config/localhost/ssl_certificate.key -out $DIR/config/localhost/ssl_certificate.pem

export MAPIC_DOMAIN=localhost

node update-configs.js

echo "Starting Container --------------------------------->"

cd $DIR/docker/compose/
./create-storage-containers.sh

echo "Starting Server --------------------------------->"

./restart.sh
