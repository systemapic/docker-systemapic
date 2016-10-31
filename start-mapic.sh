#!/bin/bash
MAPIC_BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $MAPIC_BASEDIR
cd docker/compose

export MAPIC_DOMAIN

./create-storage-containers.sh
./restart.sh