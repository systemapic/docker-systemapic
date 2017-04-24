#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# ensure domain env set (default: localhost)
if [ -z "$MAPIC_DOMAIN" ]; then
    MAPIC_DOMAIN=localhost
fi
export MAPIC_DOMAIN

# get file and name (eg. dev.mapic.io.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
COMPOSENAME=${MAPIC_DOMAIN//./}

# stop containers
docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill