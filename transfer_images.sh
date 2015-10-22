#!/bin/bash

REMOTE_SERVER=$1

if [ "$1" == "" ]; then
	echo "Must provide server (eg. ax) as first argument,"
	echo ""
	exit 1 # missing args
fi

docker save systemapic/postgis 	| pigz | pv | ssh $REMOTE_SERVER 'pigz -d | docker load'
docker save systemapic/wu 	| pigz | pv | ssh $REMOTE_SERVER 'pigz -d | docker load'
docker save systemapic/pile 	| pigz | pv | ssh $REMOTE_SERVER 'pigz -d | docker load'
