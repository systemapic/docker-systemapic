#!/bin/bash

# name of storage
STORAGE=postgis_backup_store

# create storage if not exists
RUNNING=$(docker inspect --format="{{ .Name }}" $STORAGE 2> /dev/null)
if [ "$RUNNING" != "/$STORAGE" ]; then
	docker create -v /backup/postgis --name $STORAGE systemapic/ubuntu
fi

# build
docker build -t systemapic/backup:postgis .