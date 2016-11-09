#!/bin/bash

abort () {
	echo $1
	exit 1;
}

SHOW_LOGS=yes

test "$1" = "--no-logs" && {
  SHOW_LOGS=no
  shift
}

test -n "$1" && MAPIC_DOMAIN=`echo "$1" | sed 's/\.yml$//'`

if [ -z "$MAPIC_DOMAIN" ]; then
    MAPIC_DOMAIN=localhost
fi

export MAPIC_DOMAIN

echo "--------------------------------------------------------------------"
echo "Starting services @ $MAPIC_DOMAIN"
echo "--------------------------------------------------------------------"

BASEDIR=`dirname $0`
cd $BASEDIR

# get file and name (eg. dev.mapic.io.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
ARR=${MAPIC_DOMAIN//./ }
COMPOSENAME=${ARR[0]} 

# kill, delete, start fresh, get logs
echo "# Stopping containers..."
sh stop-containers.sh
echo "# Flushing containers..."
sh delete-containers.sh
echo "# Starting containers..."
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d ||
  abort "If missing containers, try running:
        sh ${BASEDIR}/create-storage-containers.sh"
        
if [ "$SHOW_LOGS" = "yes" ]; then
  echo "Opening logs..."
  docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs -f
fi
