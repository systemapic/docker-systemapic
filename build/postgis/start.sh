#!/bin/bash

test -n "$1" || {
  echo "Usage: $0 <pg_version>"
  echo "  pg_version is in Major.Minor format"
  exit 1
} >&2

PGVER="$1"

echo "Starting PostgreSQL ${PGVER}"

DATADIR="/var/lib/postgresql/${PGVER}/main"
CONF="/etc/postgresql/${PGVER}/main/postgresql.conf"
POSTGRES="/usr/lib/postgresql/${PGVER}/bin/postgres"
INITDB="/usr/lib/postgresql/${PGVER}/bin/initdb"
USERNAME="docker"
PASS="docker"
DBNAME="systemapic"

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating Postgres data at $DATADIR"
  mkdir -p $DATADIR
fi

# test if DATADIR has content
if [ ! "$(ls -A $DATADIR)" ]; then
  echo "Initializing Postgres Database at $DATADIR"
  chown -R postgres $DATADIR
  su postgres sh -c "$INITDB $DATADIR"
  su postgres sh -c "$POSTGRES --single -D $DATADIR -c config_file=$CONF" <<< "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASS';"

  su - postgres -c "createdb $DBNAME"
  
fi

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &

wait $!
