#!/bin/bash

# get basedir
MAPIC_BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Basedir: $MAPIC_BASEDIR"

# set env
export MAPIC_DOMAIN

cd $MAPIC_BASEDIR/docker/compose
./restart.sh