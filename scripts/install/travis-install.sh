#!/bin/bash


# get working dir
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "travis-install DIR: $DIR"

# move repo to mapic/modules
REPO=$travis_repo








# # install node modules
# cd $DIR
# print_log "# Installing Node modules..."
# print_log "-> Mapic Tile Server"
# docker run -v $DIR/config/${MAPIC_DOMAIN}:/mapic/config -v $DIR/modules:/mapic/modules -w /mapic/modules/mile -it mapic/mile:latest npm install --loglevel silent
# print_log "-> Mapic Engine"
# docker run -v $DIR/config/${MAPIC_DOMAIN}:/mapic/config -v $DIR/modules:/mapic/modules -w /mapic/modules/engine -it mapic/engine:latest npm install --loglevel silent
# print_log "-> Mapic.js"
# docker run -v $DIR/config/${MAPIC_DOMAIN}:/mapic/config -v $DIR/modules:/mapic/modules -w /mapic/modules/mapic.js -it mapic/engine:latest npm install --loglevel silent

# # start server
# print_log "# Starting Mapic server..."
# cd $DIR/docker/compose/
# ./start-containers.sh --no-logs

# # run tests
# print_log "# Running tests..."
# sleep 30
# cd $DIR/scripts
# ./run-localhost-tests.sh || abort

# # show logs
# print_log "# Opening logs..."
# cd $DIR/docker/compose/
# ./show-logs.sh
