#!/bin/bash

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

STORENAME=postgresql_store_${SYSTEMAPIC_DOMAIN}
BKSTORENAME=${STORENAME}_$$

docker rename ${STORENAME} ${BKSTORENAME} || exit 1

echo "PostgreSQL store renamed to ${BKSTORENAME} during operations"

cd ${BASEDIR} &&
./do_restore.sh \
  postgis_backup_store \
  /backup/postgis/postgis-backup-last \
  ${STORENAME} \
  systemapic/postgis:latest && {
echo "Previous PGDATA store (${STORENAME}) was renamed to $BKSTORENAME"
echo "Database restores, you can now restart services"
} ||
{
  echo "Something went wrong, renaming back PostgreSQL store"
  docker rename ${BKSTORENAME} ${STORENAME}
  exit 1
}
