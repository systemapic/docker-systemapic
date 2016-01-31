#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

function prod_mode() {
	echo 'Pile | PostGIS Tile Server | Production mode'
	forever src/pile.js production >> log/pile.log
}

function dev_mode() {
	echo 'Pile Debug mode'
	nodemon -i node_modules/ src/pile.js
}

# set code dir (local dev code, or prod code from git)
# ---
# Both prod- and dev code-bases are available in the container. Prod-code is cloned from git on build, 
# while dev-code is mounted from localhost /docks/modules/wu. $SYSTEMAPIC_PRODMODE env on localhost 
# decides which code-base is in use (in effect here and in compose yml's)
if $SYSTEMAPIC_PRODMODE; then
	REPO_DIR=/systemapic/prod
else
	REPO_DIR=/systemapic/dev
fi
cd $REPO_DIR

# set env
CONFIG_DIR=$REPO_DIR/config
NODE_MODULES_DIR=$REPO_DIR/node_modules
SYSTEMAPIC_CONFIG_DIR=/systemapic/config

# ensure config
if [ ! -d "$SYSTEMAPIC_CONFIG_DIR" ]; then
	abort "Configuration not installed, should be at $SYSTEMAPIC_CONFIG_DIR. Quitting!"
fi

# install config
mkdir -p $CONFIG_DIR
cp $SYSTEMAPIC_CONFIG_DIR/pile-config.js $CONFIG_DIR/pile-config.js

# ensure node modules are installed
if [ ! -d "$NODE_MODULES_DIR" ]; then
  echo "Installing node modules..."
  npm install || abort "Failed to install node modules. Quitting!"
fi

# ensure log folder
mkdir -p $REPO_DIR/log

# start server
if $SYSTEMAPIC_PRODMODE; then
	prod_mode
else
	dev_mode
fi