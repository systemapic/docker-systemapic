#!/bin/bash

# need to setup admin for secure access
# 0. check if inited
# 1. start mongodb without auth
# 2. add admin/user with pass
# 3. restart mongo with auth config

init_mongo () {
	echo "Running MongDB start script!";

	# start without AUTH
	mongod -f /etc/mongod.conf &
	LAST_PID=$!

	# wait for up
	sleep 3

	# run script
	mongo /etc/first_run.js

	# mark inited
	touch /data/db/systemapic.inited

	# kill mongo
	kill $LAST_PID;

	# wait for down
	sleep 3
}

# if script has been updated, or never inited, run init_mongo
if [[ /etc/first_run.js -nt /data/db/systemapic.inited ]]; then
	init_mongo
fi

echo "Restarting with AUTH";
mongod -f /etc/mongod.conf --auth