#!/bin/bash

# ensure domain is set
# test -z "$MAPIC_DOMAIN" &&
#   abort "Usage: $0 <domain> (or set MAPIC_DOMAIN ENV variable, eg. export MAPIC_DOMAIN=localhost)"

BASEDIR=`dirname $0`
COMPOSEFILE="${BASEDIR}/yml/$MAPIC_DOMAIN".yml
ARR=(${MAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 
echo $COMPOSENAME
echo $COMPOSEFILE
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs -f

