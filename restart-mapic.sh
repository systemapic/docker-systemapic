#!/bin/bash
MAPIC_BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $MAPIC_BASEDIR
cd docker/compose

export MAPIC_DOMAIN

node create-storage-containers.js
./restart.sh