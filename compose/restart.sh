#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# check config file exists for wu and pile
test -f /var/www/wu/config/server-config.js || abort "ERROR: A /var/www/wu/config/server-config.js file is needed for wu to run"
test -f /var/www/pile/config/pile-config.js || abort "ERROR: A /var/www/pile/config/pile-config.js file is needed for pile to run"

# check domain ENV is set
echo "Checking host domain...$SYSTEMAPIC_DOMAIN"
[ -z "$SYSTEMAPIC_DOMAIN" ] && abort "Restart failed! Need to set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=dev.systemapic.com"

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

# kill, delete, start fresh, get logs
./kill.sh
echo -e "\e[93mDeleting containers...\e[39m"
./delete_containers.sh
echo -e "\e[93mStarting containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d || abort "If missing containers, try ./create_storage_containers.sh"
echo -e "\e[93mOpening logs...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs
