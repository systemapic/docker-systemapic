#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

# check domain ENV is set
[ -z "$SYSTEMAPIC_DOMAIN" ] && abort "Stopping containers failed! Need to set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=dev.systemapic.com"

# get file and name (eg. dev.systemapic.com.yml and dev)
COMPOSEFILE="$SYSTEMAPIC_DOMAIN".yml
ARR=(${SYSTEMAPIC_DOMAIN//./ })
COMPOSENAME=${ARR[0]} 

echo $COMPOSEFILE
echo $COMPOSENAME

echo -e "\e[93mKilling containers...\e[39m"
docker-compose -f $COMPOSEFILE -p $COMPOSENAME kill