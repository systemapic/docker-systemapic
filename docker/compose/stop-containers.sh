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

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
ARR=(${MAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill