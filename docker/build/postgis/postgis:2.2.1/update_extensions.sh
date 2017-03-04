#!/bin/bash

export PGDATABASE=template1

source /mapic/config/env.sh || exit 1
export PGUSER=$SYSTEMAPIC_PGSQL_USERNAME
export PGPASSWORD=$SYSTEMAPIC_PGSQL_PASSWORD
export PGPASSWORD=$SYSTEMAPIC_PGSQL_PASSWORD

PSQL='psql --no-password -XAt'

TOCMD=
TOMSG=
TGTVER="-"

if test "$TGTVER" != "-"; then
  TOCMD=" TO '${TGTVER}'"
  TOMSG=" to version '${TGTVER}'"
fi

WAIT=10

${PSQL} -c '\conninfo'
echo "Will update extensions on all cluster databases in $WAIT seconds"
echo "Press ^C to quit now"
sleep $WAIT

echo "Unlocking connections to ${SYSTEMAPIC_PGSQL_DBNAME}"
${PSQL} template1 <<"EOF"
 UPDATE pg_catalog.pg_database
    SET datallowconn = true
  WHERE datname='${SYSTEMAPIC_PGSQL_DBNAME}';
EOF

ret=0
dbs=0
for DB in `${PSQL} -c \
  "select datname from pg_catalog.pg_database where datname not in 
  ('template0', 'template1', 'postgres')"`; do
  # TODO: check from which version we come ?
  echo
	echo "[database ${DB}]"
  cat<<EOF | ${PSQL} --set ON_ERROR_STOP=1 ${DB} 2>&1

  SELECT 'updating postgis';
  ALTER EXTENSION postgis UPDATE;

  SELECT 'updating postgis_topology';
  ALTER EXTENSION postgis_topology UPDATE;

  SELECT 'updating postgis_tiger_geocoder';
  ALTER EXTENSION postgis_tiger_geocoder UPDATE;

  SELECT 'creating/updating systemapic extension';
  CREATE EXTENSION IF NOT EXISTS systemapic;
  ALTER EXTENSION systemapic UPDATE;
  SELECT systemapic.SP_ExtensionReload();

EOF
  ret=$((ret+$?))
  dbs=$((dbs+1))
done

echo "Locking back connections to ${SYSTEMAPIC_PGSQL_DBNAME}"
${PSQL} template1 <<"EOF"
 UPDATE pg_catalog.pg_database
    SET datallowconn = false
  WHERE datname='${SYSTEMAPIC_PGSQL_DBNAME}';
EOF

echo "${dbs} databases hit"
exit $ret
