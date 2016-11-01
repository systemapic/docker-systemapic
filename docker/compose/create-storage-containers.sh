#!/bin/bash

# default compose file
DC=docker-compose.yml


export MAPIC_DOMAIN

echo "DOMAIN -> $MAPIC_DOMAIN"

# check for compose file
DC=`dirname $0`/yml/$MAPIC_DOMAIN.yml
test -n "$1" && DC="$1"

# test helper
test -f "${DC}" || {
  echo "$DC not found try passing its path as argument" >&2
  exit 1
}

# docker create helper
dcreate() {
  name=$1
  path=$2
  if docker inspect --format='{{.Name}}' "${name}" > /dev/null 2>&1
  then
    echo "" > /dev/null 2>&1
  else
    echo "Creating ${name}..."
    docker create -v "${path}" --name "${name}" mapic/ubuntu
  fi
}

# # debug
# docker create -v /data --name store_ngu_data mapic/ubuntu
# docker create -v /data/db --name store_ngu_mongo mapic/ubuntu
# docker create -v /data --name store_ngu_redis_stats mapic/ubuntu
# docker create -v /data --name store_ngu_redis_layers mapic/ubuntu
# docker create -v /data --name store_ngu_redis_tokens mapic/ubuntu
# docker create -v /var/lib/postgresql --name store_ngu_postgis mapic/ubuntu


grep -A1 volumes_from "${DC}" |
  grep -v -- -- |
  grep -v volumes_from |
  grep -v "\s*#" | 
  sed 's/.*- *\([^ ]*\).*/\1/' |
  sort -u |
while read C; do
  # postgis backup
  echo "C: $C"
  if echo "$C" | grep -q '^postgis_backup'; then
    POSTGIS_BACKUP=$C
    dcreate $POSTGIS_BACKUP /backup/postgis || exit 1
  # data store
  elif echo "$C" | grep -q 'data'; then
    DATASTORE=$C
    dcreate $DATASTORE /data || exit 1
  # mongo
  elif echo "$C" | grep -q 'mongo'; then
    MONGO=$C
    dcreate $MONGO /data/db || exit 1
  # redis stats
  elif echo "$C" | grep -q 'redis_stats'; then
    REDISSTATS=$C
    dcreate $REDISSTATS /data || exit 1
  # redis tokens
  elif echo "$C" | grep -q 'redis_tokens'; then
    REDISTOKENS=$C
    dcreate $REDISTOKENS /data || exit 1
  # redis layers
  elif echo "$C" | grep -q 'redis_layers'; then
    REDISLAYERS=$C
    dcreate $REDISLAYERS /data || exit 1
  # postgis
  elif echo "$C" | grep -q 'postgis'; then
    POSTGIS=$C
    dcreate $POSTGIS /var/lib/postgresql || exit 1
  else
    echo "Don't know how to build referenced data container '$C'" >&2
  fi
done

exit 0





