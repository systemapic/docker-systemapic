#!/bin/bash

function abort() {
    echo "Error: $1"
    exit 1;
}

# set domain
if [ -z "$MAPIC_DOMAIN" ]; then
    MAPIC_DOMAIN=localhost
fi

# remove dots
MAPIC_DOMAIN=${MAPIC_DOMAIN//./}

# run test
docker exec -it ${MAPIC_DOMAIN}_engine_1 bash public/test/test.sh || abort