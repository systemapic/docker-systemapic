#!/bin/bash

export PGDATABASE=template1

PSQL='psql -XAt'

TOCMD=
TOMSG=
if test -z "$1"; then
  echo "Usage: $0 <target_version>" >&2
  echo "You can use '-' as target_version to use the default version" >&2
  exit 1
fi
TGTVER="$1"

if test "$TGTVER" != "-"; then
  TOCMD=" TO '${TGTVER}'"
  TOMSG=" to version '${TGTVER}'"
fi

WAIT=10

${PSQL} -c '\conninfo'
echo "Will update PostGIS on all cluster databases${TOMSG} in $WAIT seconds"
echo "Press ^C to quit now"
sleep $WAIT

ret=0
dbs=0
for DB in `${PSQL} -c \
  "select datname from pg_catalog.pg_database where datname not in 
  ('template0', 'template1', 'postgres', 'systemapic')"`; do
  # TODO: check from which version we come ?
  echo
	echo "[database ${DB}]"
  cat<<EOF | ${PSQL} --set ON_ERROR_STOP=1 ${DB} 2>&1
  SELECT 'FROM: ' || postgis_full_version();
  --SET STATEMENT_TIMEOUT TO 5000;
  SELECT 'updating postgis';
  ALTER EXTENSION postgis UPDATE${TOCMD};
  SELECT 'updating postgis_topology';
  ALTER EXTENSION postgis_topology UPDATE${TOCMD};
  SELECT 'updating postgis_tiger_geocoder';
  ALTER EXTENSION postgis_tiger_geocoder UPDATE${TOCMD};
  SELECT 'TO: ' || postgis_full_version();
EOF
  ret=$((ret+$?))
  dbs=$((dbs+1))
done

echo "${dbs} databases hit"
exit $ret
