#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

REPO_DIR=/mapic/modules/engine

# set env
NODE_MODULES_DIR=$REPO_DIR/node_modules

# ensure node modules are installed
if [ ! -d "$NODE_MODULES_DIR" ]; then
  echo "Installing node modules..."
  npm install || abort "Failed to install node modules. Quitting!"
fi

# ensure log folder
mkdir -p $REPO_DIR/log

# start server in prod or dev mode
cd $REPO_DIR
./start-server.sh
