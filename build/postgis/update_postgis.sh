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

${PSQL} -c '\conninfo'
echo "Press ENTER to update PostGIS on all cluster databases${TOMSG}"
read

ret=0
dbs=0
${PSQL} -c \
  "select datname from pg_catalog.pg_database where datname not in 
  ('template0', 'template1', 'postgres', 'systemapic')" |
while read DB; do
  # TODO: check from which version we come ?
	echo "Upgrading database ${DB} ..."
  cat<<EOF | ${PSQL} ${DB}
  SELECT 'FROM: ' || postgis_full_version();
  --SET STATEMENT_TIMEOUT TO 5000;
  SELECT '-POSTGIS-';
  ALTER EXTENSION postgis UPDATE${TOCMD};
  SELECT '-POSTGIS_TOPOLOGY-';
  ALTER EXTENSION postgis_topology UPDATE${TOCMD};
  SELECT '-POSTGIS_TIGER_GEOCODER-';
  ALTER EXTENSION postgis_tiger_geocoder UPDATE${TOCMD};
  SELECT 'TO: ' || postgis_full_version();
EOF
  ret=$((ret+$?))
  dbs=$((dbs+1))
done

echo "${dbs} databases hit"
exit $ret
