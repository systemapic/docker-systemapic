#!/bin/bash


export PGDATABASE=template1
export PSQL="psql -X"

if test -z "$1"; then
	echo "Usage: $0 <backupdir>" >&2
	exit 1
fi
BACKUPDIR="$1"
test -e "${BACKUPDIR}" || {
	echo "Backup dir ${BACKUPDIR} does not exist, will not proceed" >&2
	exit 1
}

count=`ls "${BACKUPDIR}"/db_*.dump|wc -l`
if test $count -lt 1; then
	echo "Backup dir contains no db dumps (db_*.dump), will not proceed" >&2
	exit 1
fi

WAIT=10
${PSQL} -c '\conninfo'
echo "Will restore ${count} databases dumps in $WAIT seconds"
echo "Press ^C to quit now"
sleep $WAIT

fail=0
dbs=0
if test -f ${BACKUPDIR}/_globals.dump; then
  echo "[globals]"
  psql -f ${BACKUPDIR}/_globals.dump template1
fi
for dump in ${BACKUPDIR}/db_*.dump; do
  dbs=$((dbs+1))
	dbname=`basename $dump .dump | sed 's/^db_//'`
	echo "[database ${dbname}]"
  # do not restore in an existing db
	createdb ${dbname} && pg_restore -d ${dbname} ${dump} || fail=$((fail+1))
done

echo "Attempted to restore ${dbs} databases"
if test "${fail}" -gt 0; then
  echo "WARNING: restore was not clean in ${fail} databases, check the logs!" >&2
fi

exit $fail
#psql -l
