#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

WU_DIR=/var/www/wu
WU_CONFIG_DIR=$WU_DIR/config
NPM_MODULES_DIR=$WU_DIR/npm_modules
SYSTEMAPIC_CONFIG_DIR=/systemapic/config

# check config is connected
if [ ! -d "$SYSTEMAPIC_CONFIG_DIR" ]; then
	abort "Configuration not installed, should be at $SYSTEMAPIC_CONFIG_DIR. Quitting!"
fi

# copy config file
mkdir -p $WU_CONFIG_DIR
cp $SYSTEMAPIC_CONFIG_DIR/wu-config.js $WU_CONFIG_DIR/server-config.js

# ensure npm is installed
if [ ! -d "$NPM_MODULES_DIR" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  echo "Installing node modules..."
  npm install || abort "Failed to install node modules. Quitting!"
fi

# start server
cd /var/www/wu
# ./server.sh

cd server
if $SYSTEMAPIC_PRODMODE; then

	echo 'Production mode'
	grunt prod
	echo 'Running in production mode...'
	forever server.js prod
else
	echo 'Development mode'
	grunt dev
	grunt watch &
	echo 'Running in development mode...'
	nodemon --watch ../api --watch ../config --watch server.js --watch ../routes server.js
fi
cd ..