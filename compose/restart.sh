#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# check domain ENV is set
echo "Checking host domain...$SYSTEMAPIC_DOMAIN"
[ -z "$SYSTEMAPIC_DOMAIN" ] && abort "Restart failed! Need to set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=dev.systemapic.com"

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

echo -e "\e[93mKilling containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill
echo -e "\e[93mDeleting containers...\e[39m"
./delete_containers.sh
echo -e "\e[93mStarting containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME up -d
echo -e "\e[93mOpening logs...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME logs