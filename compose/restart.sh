#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

test -n "$1" && SYSTEMAPIC_DOMAIN=`echo "$1" | sed 's/\.yml$//'`

# check SYSTEMAPIC_DOMAIN is set
test -z "$SYSTEMAPIC_DOMAIN" &&
  abort "Usage: $0 <domain> (or set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=dev.systemapic.com)"
export SYSTEMAPIC_DOMAIN

echo "--------------------------------------------------------------------"
echo "Restarting services for domain $SYSTEMAPIC_DOMAIN"
echo "--------------------------------------------------------------------"

BASEDIR=`dirname $0`
cd $BASEDIR

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="yml/$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

# kill, delete, start fresh, get logs
./stop_containers.sh
echo -e "\e[93mDeleting containers...\e[39m"
./delete_containers.sh
echo -e "\e[93mStarting containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d ||
  abort "If missing containers, try running:
        ${BASEDIR}/create_storage_containers.sh
        ${BASEDIR}/yml/${SYSTEMAPIC_DOMAIN}.yml"
echo -e "\e[93mOpening logs...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs
