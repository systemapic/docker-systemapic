#!/bin/bash
abort () { echo $1; exit 1; }
test -z $MAPIC_CLI && abort "This script must be run from mapic cli. Use: mapic install ssl (#todo!)"

# debug mode. usage: command 2>"${PIPE}" 1>"${PIPE}"
if [[ ${MAPIC_DEBUG} = true ]]; then
    PIPE=/dev/stdout
else
    PIPE=/dev/null
fi

# update config
echo "# Updating configuration..."
cd $MAPIC_ROOT_FOLDER/cli/install
node update-configs.js $MAPIC_DOMAIN 2>"${PIPE}" 1>"${PIPE}"

# todo: use docker container so no dependency on node
#       aka remove node as dep completely