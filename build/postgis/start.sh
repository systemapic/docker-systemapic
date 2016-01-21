#!/bin/bash

# test -n "$1" || {
#   echo "Usage: $0 <pg_version>"
#   echo "  pg_version is in Major.Minor format"
#   exit 1
# } >&2

PGVER="$1"

DATADIR="/var/lib/postgresql/${PGVER}/main"
CONF="/etc/postgresql/${PGVER}/main/postgresql.conf"
BINDIR="/usr/lib/postgresql/${PGVER}/bin/"
POSTGRES="${BINDIR}/postgres"
INITDB="${BINDIR}/initdb"

# TODO: take these as environment variable ?
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

# test if DATADIR has content, or call initdb
if [ ! "$(ls -A $DATADIR)" ]; then
  EXISTING_CLUSTER=no
  echo "Initializing PostgreSQL cluster at $DATADIR"
  su postgres sh -c "$INITDB $DATADIR" || exit 1
fi

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

echo "--- Starting PostgreSQL ${PGVER}"
su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &
pgsqlpid=$!

export PGDATABASE=template1
export PGUSER=postgres
export PGHOST=localhost

echo "Waiting for postgres start for restoring databases"
PSQL="psql -X"
while :; do
        sleep 5;
        sudo -u postgres ${PSQL} -c "select version();" && break;
done

if test -n "${SYSTEMAPIC_RESTORE_POSTGIS_FROM}"; then
  if test "${EXISTING_CLUSTER}" = 'yes'; then
    echo "SYSTEMAPIC_RESTORE_POSTGIS_FROM is set but DATADIR ${DATADIR} is pre-existing" >&2
    exit 1
  else
    echo "Attempting restore from ${SYSTEMAPIC_RESTORE_POSTGIS_FROM}"
    `dirname $0`/restore_databases.sh ${SYSTEMAPIC_RESTORE_POSTGIS_FROM}
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

  -- Ensure user owns all databases
  FOR rec IN
    SELECT d.datname, u.usename
    FROM pg_catalog.pg_user u, pg_database d
    WHERE u.usesysid = d.datdba
      AND u.usename != '${USERNAME}'
      AND d.datname NOT IN ( 'template1','template0','postgres' )
  LOOP
    RAISE WARNING 'Changing ownership of database % from "%" to "${USERNAME}"', rec.datname, rec.usename;
    EXECUTE 'ALTER DATABASE ' || quote_ident(rec.datname)
      || ' OWNER TO "${USERNAME}"';
  END LOOP;

END;
\$\$
LANGUAGE 'plpgsql';
EOF

# Ensure DBNAME exists or create one
# (cannot be done in the DO block above)
exists=`sudo -u postgres ${PSQL} -tA -c "\
SELECT 'yes' FROM pg_catalog.pg_database WHERE datname = '${DBNAME}' \
" template1`
if test "$exists" != "yes"; then
  echo "WARNING: Creating missing \"${DBNAME}\" database";
  sudo -u postgres createdb -O "${USERNAME}" "${DBNAME}"
fi

# TODO: drop unkonwn users ?

wait $pgsqlpid
