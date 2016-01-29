#!/bin/bash

test -n "$1" || {
  echo "Usage: $0 <docker-compose.yml>" >&2
  exit 1
}
DC="$1"

dcreate() {
  name=$1
  path=$2
  if docker inspect --format='{{.Name}}' "${name}" > /dev/null 2>&1
  then
    echo " ${name} exists";
  else
    docker create -v "${path}" --name "${name}" systemapic/ubuntu
  fi
}

grep -A1 volumes_from "${DC}" |
  grep -v -- -- |
  grep -v volumes_from |
  grep -v "\s*#" | 
  sed 's/.*- *\([^ ]*\).*/\1/' |
  sort -u |
while read C; do
  # postgis backup
  if echo "$C" | grep -q '^postgis_backup'; then
    POSTGIS_BACKUP=$C
    echo "Creating PostGIS backup volume $POSTGIS_BACKUP"
    dcreate $POSTGIS_BACKUP /backup/postgis || exit 1
  # data store
  elif echo "$C" | grep -q '^data_store'; then
    DATASTORE=$C
    echo "Creating Data Store volume $DATASTORE"
    dcreate $DATASTORE /data || exit 1
  # mongo
  elif echo "$C" | grep -q '^mongo_store'; then
    MONGO=$C
    echo "Creating MongoDB volume $MONGO"
    dcreate $MONGO /data/db || exit 1
  # redis stats
  elif echo "$C" | grep -q '^redis_stats'; then
    REDISSTATS=$C
    echo "Creating Redis Stats volume $REDISSTATS"
    dcreate $REDISSTATS /data || exit 1
  # postgis
  elif echo "$C" | grep -q '^post'; then
    POSTGIS=$C
    echo "Creating PostGIS volume $POSTGIS"
    dcreate $POSTGIS /var/lib/postgresql || exit 1
  # redis tokens
  elif echo "$C" | grep -q 'redis_tokens'; then
    REDISTOKENS=$C
    echo "Creating Redis Tokens volume $REDISTOKENS"
    dcreate $REDISTOKENS /data || exit 1
  # redis layers
  elif echo "$C" | grep -q '^redis'; then
    REDISLAYERS=$C
    echo "Creating Redis Layers volume $REDISLAYERS"
    dcreate $REDISLAYERS /data || exit 1
  else
    echo "Don't know how to build referenced data container '$C'" >&2
  fi
done

exit 0





