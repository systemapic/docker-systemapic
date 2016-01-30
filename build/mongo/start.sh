#!/bin/bash

# need to setup admin for secure access
# 0. check if inited
# 1. start mongodb without auth
# 2. add admin/user with pass
# 3. restart mongo with auth config

CONFIGFILE=/etc/mongod.conf

init_mongo () {
	echo "Running MongDB start script!";

	# start without AUTH
	mongod -f $CONFIGFILE &
	LAST_PID=$!

	# wait for up
	sleep 3

	# run script
	mongo /etc/init_mongo.js

	# mark inited
	touch /data/db/systemapic.inited

	# kill mongo
	kill $LAST_PID;

	# wait for down
	sleep 3
}

# if script has been updated, or never inited, run init_mongo
if [[ /etc/init_mongo.js -nt /data/db/systemapic.inited ]]; then
	init_mongo
fi

echo "Starting MongoDB with AUTH";
mongod -f $CONFIGFILE --auth