#!/bin/bash

BASEDIR=`dirname $0`
COMPOSEFILE="${BASEDIR}/yml/$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs $@
