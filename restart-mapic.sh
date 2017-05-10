#!/bin/bash

function abort() {
    echo $1
    exit 1;
}


# check MAPIC_DOMAIN is set
test -z "$MAPIC_DOMAIN" &&
  abort "Usage: $0 <domain> (or set MAPIC_DOMAIN environment variable: export MAPIC_DOMAIN=domain.example.com)"

# get basedir
test -z "$MAPIC_ROOT_FOLDER" &&
    MAPIC_ROOT_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# set env
export MAPIC_DOMAIN
export MAPIC_ROOT_FOLDER

cd $MAPIC_ROOT_FOLDER/docker/compose
./restart.sh