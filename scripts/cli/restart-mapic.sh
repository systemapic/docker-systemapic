#!/bin/bash

fail () {
    echo "$@"
    exit 1
}

cd $MAPIC_ROOT_FOLDER/docker/compose

# kill, delete
bash stop-containers.sh
bash delete-containers.sh &> /dev/null

# todo:
# mapic stop
# mapic flush

# get file and name (eg. dev.mapic.io.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
COMPOSENAME=${MAPIC_DOMAIN//./}

# start
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d || fail "Couldn't start Mapic."

echo ""
echo "Mapic is up and running @ https://$MAPIC_DOMAIN"