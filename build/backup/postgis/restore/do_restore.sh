#!/bin/bash

# Example:
# ./do_restore.sh postgis_backup_store /backup/postgis/postgis-backup-last postgresql94_store_dev2 systemapic/postgis:94-21

abort()
{
	echo $1 >&2
	exit 1
}

if test -z "$3"; then
	abort "Usage $0 <backup_store> <backup_path> <pgdata_store> <postgis_image>"
fi
BACKUP_STORAGE_CONTAINER="$1"
BACKUP_PATH="$2"
PGDATA_RESTORE_CONTAINER="$3"
POSTGIS_IMAGE="$4"

# check SYSTEMAPIC_DOMAIN is set
test -z "$SYSTEMAPIC_DOMAIN" &&
  abort "please set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=localhost"

BASEDIR=$(cd `dirname $0`; pwd)

# Create storage only if needed ?
if docker inspect --format='{{.Name}}' "${PGDATA_RESTORE_CONTAINER}" > /dev/null 2>&1
then
  echo " ${PGDATA_RESTORE_CONTAINER} exists";
else
  echo "--- Creating pgdata volume ${PGDATA_RESTORE_CONTAINER}"
  docker create -v /var/lib/postgresql \
    --name ${PGDATA_RESTORE_CONTAINER} \
    systemapic/ubuntu || exit 1
fi


CONFIGDIR=${BASEDIR}/../../../../config/${SYSTEMAPIC_DOMAIN}

container_name=postgis_restore_$$

echo "--- Running ${POSTGIS_IMAGE} with name ${container_name} and volume ${PGDATA_RESTORE_CONTAINER}"
docker run --rm --name ${container_name} \
	--volume ${CONFIGDIR}:/systemapic/config \
	--volumes-from ${BACKUP_STORAGE_CONTAINER} \
	--volumes-from ${PGDATA_RESTORE_CONTAINER} \
	-e "PGHOST=localhost" \
	-e "SYSTEMAPIC_RESTORE_POSTGIS_FROM=${BACKUP_PATH}" \
	${POSTGIS_IMAGE} || exit 1


echo "Restored PGDATA should now be in ${PGDATA_RESTORE_CONTAINER}"

#--volume /root:/root_host \
#./restore_databases.sh $BACKUP_PATH
