#!/bin/bash

test -n "$1" || {
  echo "Usage: $0 <pg_version>"
  echo "  pg_version is in Major.Minor format"
  exit 1
} >&2

PGVER="$1"

DATADIR="/var/lib/postgresql/${PGVER}/main"
CONF="/etc/postgresql/${PGVER}/main/postgresql.conf"
BINDIR="/usr/lib/postgresql/${PGVER}/bin/"
POSTGRES="${BINDIR}/postgres"
INITDB="${BINDIR}/initdb"

# fix ssl
mkdir /etc/ssl/private-copy
mv /etc/ssl/private/* /etc/ssl/private-copy/
rm -r /etc/ssl/private
mv /etc/ssl/private-copy /etc/ssl/private
chmod -R 0700 /etc/ssl/private
chown -R postgres /etc/ssl/private

echo "Starting PostGIS"
source /mapic/config/env.sh || exit 1

USERNAME="${SYSTEMAPIC_PGSQL_USERNAME}"
PASS="${SYSTEMAPIC_PGSQL_PASSWORD}"
DBNAME="${SYSTEMAPIC_PGSQL_DBNAME}"

echo "PostgreSQL Configuration:"
echo "===================================="
echo "PostgreSQL version: $PGVER"
echo "PostgreSQL username: $USERNAME"
echo "PostgreSQL auth: $PASS"
echo "PostgreSQL database: $DBNAME"
echo "===================================="

EXISTING_CLUSTER=yes

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating PostgreSQL DATADIR at $DATADIR"
  mkdir -p ${DATADIR} || exit 1
fi

# set proper ownership of datadir, if missing
find ${DATADIR} \! -user postgres -print0 | xargs -0r chown postgres || exit 1

# test if DATADIR has content, or call initdb
if [ ! "$(ls -A $DATADIR)" ]; then
  EXISTING_CLUSTER=no
  echo "Initializing PostgreSQL cluster at $DATADIR"
  su postgres sh -c "$INITDB $DATADIR" || exit 1
fi

cleanup()
{
  if test -n "$pgsqlpid"; then
    echo "Sending SIGTERM to postgres"
    kill -s SIGTERM $pgsqlpid
    wait $pgsqlpid
  fi
}

trap "cleanup" EXIT

echo "--- Starting PostgreSQL ${PGVER}"
su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &
pgsqlpid=$!

export PGDATABASE=template1
export PGUSER=postgres

echo "Waiting for PostgreSQL start"
PSQL="psql -X"
while :; do
        sleep 10;
        sudo -u postgres ${PSQL} -c "select version();" && break;
done

if test -n "${SYSTEMAPIC_RESTORE_POSTGIS_FROM}"; then
  if test "${EXISTING_CLUSTER}" = 'yes'; then
    echo "SYSTEMAPIC_RESTORE_POSTGIS_FROM is set but DATADIR ${DATADIR} is pre-existing" >&2
    exit 1
  else
    echo "Attempting restore from ${SYSTEMAPIC_RESTORE_POSTGIS_FROM}"
    sudo -u postgres `dirname $0`/restore_databases.sh ${SYSTEMAPIC_RESTORE_POSTGIS_FROM}
  fi
  exit 0
fi

# ensure USERNAME exists, owns all databases (except system ones)
# and has the given password
cat<<EOF | sudo -u postgres ${PSQL} -tA template1
DO \$\$
DECLARE
  rec RECORD;
BEGIN

  -- Ensure user exists and has given password
  IF NOT EXISTS (
    SELECT 1 FROM pg_catalog.pg_user WHERE usename = '${USERNAME}'
    )
  THEN
    -- Create user
    RAISE WARNING 'Creating missing "${USERNAME}" user';
    CREATE USER "${USERNAME}" WITH SUPERUSER PASSWORD '${PASS}';
  ELSE
    -- Set correct password and "superuser" flag
    RAISE NOTICE 'Ensuring "${USERNAME}" password';
    ALTER USER "${USERNAME}" SUPERUSER PASSWORD '${PASS}';
  END IF;

END;
\$\$
LANGUAGE 'plpgsql';
EOF

# Ensure DBNAME exists or create one
# (cannot be done in the DO block above)
allows=`sudo -u postgres ${PSQL} -tA -c "\
SELECT datallowconn FROM pg_catalog.pg_database WHERE datname = '${DBNAME}' \
" template1`
if test x"$allows" = "x"; then
  echo "WARNING: Creating missing \"${DBNAME}\" database";
  sudo -u postgres createdb -O "${USERNAME}" "${DBNAME}"
  allows=t # just-created database will allow connection
fi

# Ensure DBNAME is loaded with needed extensions,
# NOTE: if connections are not allowed, we take it as a sign
#       of completed templating work.
if test x"$allows" = "xt"; then
echo "NOTICE: Spatially enabling \"${DBNAME}\" database";
cat<<EOF | sudo -u postgres ${PSQL} --set ON_ERROR_STOP=1 -tA "${DBNAME}" || exit 1
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
SELECT postgis_full_version();
EOF
else
echo "NOTICE: Assuming '${DBNAME}' is already spatially enabled"
fi

# Ensure DBNAME is marked as a template
echo "NOTICE: Ensuring '${DBNAME}' is an unconnectable template"
cat<<EOF | sudo -u postgres ${PSQL} -tA template1
UPDATE pg_catalog.pg_database
   SET datistemplate = true,
       datallowconn = false
 WHERE datname='${DBNAME}';
EOF

# TODO: drop unkonwn users ?

wait $pgsqlpid
pgsqlpid= # to avoid the cleanup failure
