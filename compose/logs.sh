#!/bin/bash

# ensure domain is set
test -z "$SYSTEMAPIC_DOMAIN" &&
  abort "Usage: $0 <domain> (or set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=localhost)"

BASEDIR=`dirname $0`
COMPOSEFILE="${BASEDIR}/yml/$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs -f

