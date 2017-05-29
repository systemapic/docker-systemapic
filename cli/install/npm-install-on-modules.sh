#!/bin/bash
abort () { echo $1; exit 1; }
test -z $MAPIC_CLI && abort "This script must be run from mapic cli. Use: mapic install ssl (#todo!)"

# debug mode. usage: command 2>"${PIPE}" 1>"${PIPE}"
if [[ ${MAPIC_DEBUG} = true ]]; then
    PIPE=/dev/stdout
else
    PIPE=/dev/null
fi

cd $MAPIC_ROOT_FOLDER
echo "Installing node modules for Mile"
docker run -v $MAPIC_ROOT_FOLDER/config/${MAPIC_DOMAIN}:/mapic/config -v $MAPIC_ROOT_FOLDER/modules:/mapic/modules -w /mapic/modules/mile -it mapic/mile:latest npm install 2>"${PIPE}" 1>"${PIPE}"
echo "Installing node modules for Engine"
docker run -v $MAPIC_ROOT_FOLDER/config/${MAPIC_DOMAIN}:/mapic/config -v $MAPIC_ROOT_FOLDER/modules:/mapic/modules -w /mapic/modules/engine -it mapic/engine:latest npm install 2>"${PIPE}" 1>"${PIPE}"
echo "Installing node modules for Mapic.js"
docker run -v $MAPIC_ROOT_FOLDER/config/${MAPIC_DOMAIN}:/mapic/config -v $MAPIC_ROOT_FOLDER/modules:/mapic/modules -w /mapic/modules/mapic.js -it mapic/engine:latest npm install 2>"${PIPE}" 1>"${PIPE}"
echo "All node modules installed."

# todo: make each entrypoint.sh respectively build node modules when needed
# tood: use yarn