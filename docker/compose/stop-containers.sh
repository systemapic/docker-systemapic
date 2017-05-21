#!/bin/bash

# get file and name (eg. dev.mapic.io.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
COMPOSENAME=${MAPIC_DOMAIN//./}

# stop containers
docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill