#!/bin/bash

# MongoDB needs to be inited with auth settings
# ---------------------------------------------
# 1: check if inited
# 1.1: start mongodb without auth
# 1.2: add admin/user with pass
# 2: restart mongo with auth config

# config path (never changes)
CONFIGFILE=/mapic/config/mongod.conf

function abort() {
	echo $1
	exit 1;
}

init_mongo () {
	echo "Running MongDB start script!";

	# start without AUTH
	mongod -f $CONFIGFILE &
	LAST_PID=$!

	# wait for up
	sleep 3 # todo: check if up instead

	# run init script (adding AUTH capabilities)
	mongo /init_mongo.js

	# kill mongo
	kill $LAST_PID;

	# wait for down
	sleep 3 # todo: check if down instead

	# mark inited
	touch /data/db/mapic.inited
}

# ensure log dir
touch /etc/mongod.log

# if script has been updated, or never inited, run init_mongo
if [[ /init_mongo.js -nt /data/db/mapic.inited ]]; then
	init_mongo || abort "Failed to initialize MongoDB. Quitting!"
fi

# echo "Starting MongoDB with AUTH";
mongod -f $CONFIGFILE --auth || abort "Failed to start MongodB. Quitting!"