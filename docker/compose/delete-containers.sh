#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# check domain ENV is set
[ -z "$MAPIC_DOMAIN" ] && abort "Delete failed! Need to set MAPIC_DOMAIN ENV variable, eg. export MAPIC_DOMAIN=dev.mapic.io"

# get name
COMPOSENAME=${MAPIC_DOMAIN//./}

# remove stale containers
docker rm "$COMPOSENAME"_nginx_1
docker rm "$COMPOSENAME"_mile_1
docker rm "$COMPOSENAME"_engine_1
docker rm "$COMPOSENAME"_redislayers_1
docker rm "$COMPOSENAME"_redisstats_1
docker rm "$COMPOSENAME"_redistemp_1
docker rm "$COMPOSENAME"_mongo_1
docker rm "$COMPOSENAME"_postgis_1
