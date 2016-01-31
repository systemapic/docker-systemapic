#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

function dev_mode() {
	echo 'Development mode'
	grunt dev
	grunt watch &
	echo 'Running dev mode...'
	nodemon --watch ../api --watch ../config --watch server.js --watch ../routes server.js
}

function prod_mode() {
	echo 'Production mode'
	grunt prod
	echo 'Running prod mode...'
	forever server.js
}

# Set directory of code-base (local dev code, or prod code from git)
# ------------------------------------------------------------------
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
cp $SYSTEMAPIC_CONFIG_DIR/wu-config.js $CONFIG_DIR/wu-config.js

# ensure node modules are installed
if [ ! -d "$NODE_MODULES_DIR" ]; then
  echo "Installing node modules..."
  npm install || abort "Failed to install node modules. Quitting!"
fi

# ensure log folder
mkdir -p $REPO_DIR/log

# start server in prod or dev mode
cd $REPO_DIR/server
if $SYSTEMAPIC_PRODMODE; then
	prod_mode
else
	dev_mode
fi