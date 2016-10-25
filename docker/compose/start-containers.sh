#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

SHOW_LOGS=yes

test "$1" = "--no-logs" && {
  SHOW_LOGS=no
  shift
}

test -n "$1" && MAPIC_DOMAIN=`echo "$1" | sed 's/\.yml$//'`

# check MAPIC_DOMAIN is set
test -z "$MAPIC_DOMAIN" &&
  abort "Usage: $0 <domain> (or set MAPIC_DOMAIN ENV variable, eg. export MAPIC_DOMAIN=localhost)"
export MAPIC_DOMAIN

echo "--------------------------------------------------------------------"
echo "Starting services @ $MAPIC_DOMAIN"
echo "--------------------------------------------------------------------"

BASEDIR=`dirname $0`
cd $BASEDIR

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="yml/$MAPIC_DOMAIN".yml
ARR=(${MAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

# kill, delete, start fresh, get logs
echo -e "# Stopping containers..."
./stop_containers.sh
echo -e "# Flushing containers..."
./delete_containers.sh
echo -e "# Starting containers..."
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d ||
  abort "If missing containers, try running:
        ${BASEDIR}/create_storage_containers.sh
        ${BASEDIR}/yml/${MAPIC_DOMAIN}.yml"

if [ "$SHOW_LOGS" = "yes" ]; then
  echo -e "\e[93mOpening logs...\e[39m"
  docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs -f
fi
