#!/bin/bash

# name of storage
STORAGE=store_dev_postgis_backup

# create storage if not exists
RUNNING=$(docker inspect --format="{{ .Name }}" $STORAGE 2> /dev/null)
if [ "$RUNNING" != "/$STORAGE" ]; then
	echo "Creating $STORAGE volume..."
	docker create -v /backup/postgis --name $STORAGE systemapic/ubuntu
fi

# build
# docker build -t systemapic/backup:postgis .
docker build -t systemapic/postgis:backup .
