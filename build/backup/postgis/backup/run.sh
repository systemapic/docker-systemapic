#!/bin/bash

STORAGE_CONTAINER=postgis_backup_store
BACKUP_PATH=/backup/postgis

abort() {
	echo $1 >&2
	exit 1;
}

test -n "$1" && SYSTEMAPIC_DOMAIN=`echo "$1" | sed 's/\.yml$//'`

# check SYSTEMAPIC_DOMAIN is set
test -z "$SYSTEMAPIC_DOMAIN" &&
  abort "Usage: $0 <domain> (or set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=localhost)"
export SYSTEMAPIC_DOMAIN

BASEDIR=$(cd `dirname $0`; pwd)
CONFIG=${BASEDIR}/../../../../config/${SYSTEMAPIC_DOMAIN}

#systemapic/postgis   backup

#docker build -t systemapic/postgis backup .
#docker create -v /data --name $STORAGE_CONTAINER systemapic/ubuntu
docker run -ti --rm \
	--link ${SYSTEMAPIC_DOMAIN}_postgis_1:postgis \
  --volumes-from ${STORAGE_CONTAINER} \
  --volume ${CONFIG}:/systemapic/config \
	systemapic/postgis:backup \
	/tmp/do_backup.sh || exit 1

echo "Backup store: ${STORAGE_CONTAINER}"
