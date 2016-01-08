#!/bin/bash


if test -z "$3"; then
	echo "Usage $0 <backup_store_name> <backup_store_path> <pgdata_store_name>" >&2
	exit 1
fi
BACKUP_STORAGE_CONTAINER="$1"
BACKUP_PATH="$2"
PGDATA_RESTORE_CONTAINER="$3"

# Create storage only if needed ?
#docker rm $PGDATA_RESTORE_CONTAINER
docker create -v /var/lib/postgresql \
	--name $PGDATA_RESTORE_CONTAINER \
	systemapic/ubuntu || exit 1

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
