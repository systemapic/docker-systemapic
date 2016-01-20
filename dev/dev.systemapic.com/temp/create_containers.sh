#!/bin/bash


PREFIX=store_dev
SUFFIX=tmp10


# postgis backup
POSTGIS_BACKUP=$PREFIX"_postgis_backup_"$SUFFIX
echo "Creating PostGIS backup volume $POSTGIS_BACKUP"
docker create -v /backup/postgis --name $POSTGIS_BACKUP systemapic/ubuntu || exit 1;

# postgis
POSTGIS=$PREFIX"_postgis_"$SUFFIX
echo "Creating PostGIS volume $POSTGIS"
docker create -v /var/lib/postgresql --name $POSTGIS systemapic/ubuntu || exit 1;

# mongo
MONGO=$PREFIX"_mongo_"$SUFFIX
echo "Creating MongoDB volume $MONGO"
docker create -v /data/db --name $MONGO systemapic/ubuntu || exit 1;

# redis layers
REDISLAYERS=$PREFIX"_redis_layers_"$SUFFIX
echo "Creating Redis Layers volume $REDISLAYERS"
docker create -v /data --name $REDISLAYERS systemapic/ubuntu || exit 1;

# redis stats
REDISSTATS=$PREFIX"_redis_stats_"$SUFFIX
echo "Creating Redis Stats volume $REDISSTATS"
docker create -v /data --name $REDISSTATS systemapic/ubuntu || exit 1;

# redis tokens
REDISTOKENS=$PREFIX"_redis_tokens_"$SUFFIX
echo "Creating Redis Tokens volume $REDISTOKENS"
docker create -v /data --name $REDISTOKENS systemapic/ubuntu || exit 1;

# data store
DATASTORE=$PREFIX"_data_"$SUFFIX
echo "Creating Data Store volume $DATASTORE"
docker create -v /data --name $DATASTORE systemapic/ubuntu || exit 1;