#!/bin/bash

fail () {
    echo "$@"
    exit 1
}

cd $MAPIC_ROOT_FOLDER/docker/compose
bash stop-containers.sh || fail "Couldn't stop Mapic. Try `docker ps` and kill processes manually."
echo ""
echo "Mapic is stopped."