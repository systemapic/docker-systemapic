#!/bin/bash

STORAGE_CONTAINER=postgis_backup_store
BACKUP_PATH=/backup/postgis

docker build -t debug/pg_backup .
#docker create -v /data --name $STORAGE_CONTAINER systemapic/ubuntu
docker run --rm \
	--link dev_postgis_1:postgis --volumes-from $STORAGE_CONTAINER \
	systemapic/backup:postgis \
	/tmp/do_backup.sh 
