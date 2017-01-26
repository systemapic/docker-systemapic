#!/bin/bash
function abort() {
	echo $1
	exit 1;
}

# check domain ENV is set
echo "Checking host domain...$MAPIC_DOMAIN"
[ -z "$MAPIC_DOMAIN" ] && abort "Build failed! Need to set MAPIC_DOMAIN ENV variable, eg. export MAPIC_DOMAIN=dev.mapic.io"

# create crypto
if test -f dhparams.pem; then
  echo 'Using pre-existing Strong Diffie-Hellmann Group'
else
  echo 'Creating Strong Diffie-Hellmann Group'
  openssl dhparam -out dhparams.pem 2048 || exit 1
fi

# build
echo 'Building image'
docker build -t mapic/nginx:latest . || exit 1
