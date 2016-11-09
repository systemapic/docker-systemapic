#!/bin/bash

test -n "$1" && MAPIC_DOMAIN=`echo "$1" | sed 's/\.yml$//'`

if [ -z "$MAPIC_DOMAIN" ]; then
    MAPIC_DOMAIN=localhost
fi

export MAPIC_DOMAIN

# get file and name (eg. dev.mapic.io.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
ARR=(${MAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs -f