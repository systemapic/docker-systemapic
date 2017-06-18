#!/bin/bash

fail () {
    echo "$@"
    exit 1
}

# get file and name (eg. dev.mapic.io.yml and dev)
cd $MAPIC_ROOT_FOLDER/docker/compose
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
COMPOSENAME=${MAPIC_DOMAIN//./}

# start
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d || fail "Couldn't start Mapic."

echo ""
echo "Mapic is up and running @ https://$MAPIC_DOMAIN"