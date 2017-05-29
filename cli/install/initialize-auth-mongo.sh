#!/bin/bash
abort () { echo $1; exit 1; }
test -z $MAPIC_CLI && abort "This script must be run from mapic cli. Use: mapic install ssl (#todo!)"

# debug mode. usage: command 2>"${PIPE}" 1>"${PIPE}"
if [[ ${MAPIC_DEBUG} = true ]]; then
    PIPE=/dev/stdout
else
    PIPE=/dev/null
fi

# todo: get volumes-from name automaticall
# from env: MAPIC_STORE_NAME_DOMAIN = 
#           $MAPIC_STORE_PREFIX + $CONTAINER_NAME + $MAPIC_DOMAIN
#           mapic_store + mongo + localhost
#
#           - or just set all MAPIC_STORE_MONGO=mongo_store_localhost
#                             MAPIC_STORE_POSTGIS=mongo_store_postgis
#                             etc. this is prob better.


# init mongo
echo "# Initializing Mongo database"
docker run -v "$MAPIC_ROOT_FOLDER/config/$MAPIC_DOMAIN":/mapic/config --volumes-from mongo_store_localhost -it mapic/mongo:latest /init.sh 2>"${PIPE}" 1>"${PIPE}"
