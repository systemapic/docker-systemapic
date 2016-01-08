#!/bin/bash

STORAGE_CONTAINER=postgis_backup_store
BACKUP_PATH=/backup/postgis

docker build -t debug/pg_backup .
docker create -v /data --name $STORAGE_CONTAINER systemapic/ubuntu
docker run --link dev_postgis_1:postgis --volumes-from $STORAGE_CONTAINER -e "PGHOST=postgis" -it debug/pg_backup /tmp/backup_databases.sh $BACKUP_PATH