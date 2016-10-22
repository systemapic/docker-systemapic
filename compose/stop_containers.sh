#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# check domain ENV is set
[ -z "$MAPIC_DOMAIN" ] && abort "Stopping containers failed! Need to set MAPIC_DOMAIN ENV variable, eg. export MAPIC_DOMAIN=dev.systemapic.com"

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
ARR=(${MAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill