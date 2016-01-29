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

# check config file exists for wu and pile
#test -f /var/www/wu/config/server-config.js || abort "ERROR: A /var/www/wu/config/server-config.js file is needed for wu to run"
#test -f /var/www/pile/config/pile-config.js || abort "ERROR: A /var/www/pile/config/pile-config.js file is needed for pile to run"

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

# kill, delete, start fresh, get logs
echo -e "\e[93mKilling containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill
echo -e "\e[93mDeleting containers...\e[39m"
./delete_containers.sh
echo -e "\e[93mStarting containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d || abort "If missing containers, try ./create_storage_containers.sh"
echo -e "\e[93mOpening logs...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs
