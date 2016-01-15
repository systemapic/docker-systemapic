#!/bin/bash

# Example:
# ./do_restore.sh postgis_backup_store /backup/postgis/postgis-backup-last postgresql94_store_dev2 systemapic/postgis:94-21

if test -z "$3"; then
	echo "Usage $0 <backup_store> <backup_path> <pgdata_store> <postgis_image>" >&2
	exit 1
fi
BACKUP_STORAGE_CONTAINER="$1"
BACKUP_PATH="$2"
PGDATA_RESTORE_CONTAINER="$3"
POSTGIS_IMAGE="$4"

# Create storage only if needed ?
#docker rm $PGDATA_RESTORE_CONTAINER

echo "--- Creating pgdata volume ${PGDATA_RESTORE_CONTAINER}"
docker create -v /var/lib/postgresql \
	--name ${PGDATA_RESTORE_CONTAINER} \
	systemapic/ubuntu || exit 1

container_name=postgis_restore_$$

echo "--- Running ${POSTGIS_IMAGE} with name ${container_name} and volume ${PGDATA_RESTORE_CONTAINER}"
docker run --rm --name ${container_name} \
	--volumes-from ${BACKUP_STORAGE_CONTAINER} \
	--volumes-from ${PGDATA_RESTORE_CONTAINER} \
	-e "PGHOST=localhost" \
	-e "SYSTEMAPIC_RESTORE_POSTGIS_FROM=${BACKUP_PATH}" \
	${POSTGIS_IMAGE} || exit 1


echo "Restored PGDATA should now be in ${PGDATA_RESTORE_CONTAINER}"

#--volume /root:/root_host \
#./restore_databases.sh $BACKUP_PATH
