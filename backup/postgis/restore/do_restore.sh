#!/bin/bash

BACKUP_STORAGE_CONTAINER=postgis_backup_store
BACKUP_PATH=/backup/postgis/postgis_store_dev2-dbdumps-20160107

PGDATA_RESTORE_CONTAINER=postgis_store_dev2_restore

# Create storage only if needed ?
docker rm $PGDATA_RESTORE_CONTAINER
docker create -v /var/lib/postgresql --name $PGDATA_RESTORE_CONTAINER systemapic/ubuntu

docker build -t debug/pg_restore .
docker run --rm \
	--volumes-from $BACKUP_STORAGE_CONTAINER \
	--volumes-from $PGDATA_RESTORE_CONTAINER \
	-e "PGHOST=localhost" \
	-it debug/pg_restore \
	./restore_databases.sh $BACKUP_PATH

echo "docker run returned $?"
echo "Restored PGDATA should now be in ${PGDATA_RESTORE_CONTAINER}"

#--volume /root:/root_host \
#./restore_databases.sh $BACKUP_PATH
