#!/bin/bash

# test -n "$1" || {
#   echo "Usage: $0 <pg_version>"
#   echo "  pg_version is in Major.Minor format"
#   exit 1
# } >&2

PGVER="$1"
PGVER=9.4
echo "Starting PostgreSQL ${PGVER}"

DATADIR="/var/lib/postgresql/${PGVER}/main"
CONF="/etc/postgresql/${PGVER}/main/postgresql.conf"
POSTGRES="/usr/lib/postgresql/${PGVER}/bin/postgres"
INITDB="/usr/lib/postgresql/${PGVER}/bin/initdb"
USERNAME="docker"
PASS="docker"
DBNAME="systemapic"
EXISTING_CLUSTER=yes

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating PostgreSQL DATADIR at $DATADIR"
  mkdir -p ${DATADIR} || exit 1
fi

# set ownership of datadir
chown -R postgres ${DATADIR} || exit 1

# test if DATADIR has content
if [ ! "$(ls -A $DATADIR)" ]; then
  EXISTING_CLUSTER=no
  echo "Initializing Postgres Database at $DATADIR"
  # chown -R postgres $DATADIR
  su postgres sh -c "$INITDB $DATADIR" || exit 1

  su postgres sh -c "$POSTGRES --single -D $DATADIR -c config_file=$CONF"<<EOF || exit 1
CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASS';
CREATE DATABASE $DBNAME;
EOF
fi

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &
pgsqlpid=$!

if test -n "${SYSTEMAPIC_RESTORE_POSTGIS_FROM}"; then
  if test "${EXISTING_CLUSTER}" = 'yes'; then
    echo "SYSTEMAPIC_RESTORE_POSTGIS_FROM is set but DATADIR ${DATADIR} is pre-existing" >&2
    exit 1
  else
    echo "Waiting for postgres start for restoring databases"
    export PGDATABASE=template1
    PSQL="psql -X"
    while :; do
            sleep 5;
            ${PSQL} -c "select version();" && break;
    done
    echo "Attempting restore from ${SYSTEMAPIC_RESTORE_POSTGIS_FROM}"
    `dirname $0`/restore_databases.sh ${SYSTEMAPIC_RESTORE_POSTGIS_FROM}
  fi
else
  wait $pgsqlpid
fi
