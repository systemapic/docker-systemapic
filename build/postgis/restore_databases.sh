#!/bin/bash


export PGDATABASE=template1
export PSQL="psql -X"

if test -z "$1"; then
	echo "Usage: $0 <backupdir>" >&2
	exit 1
fi
BACKUPDIR="$1"
test -e "${BACKUPDIR}" || {
	echo "Backup dir does not exist, will not proceed" >&2
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
for dump in ${BACKUPDIR}/db_*.dump; do
  dbs=$((dbs+1))
	dbname=`basename $dump .dump | sed 's/^db_//'`
	echo "[database ${dbname}]"
	createdb ${dbname} && {
    pg_restore -d ${dbname} ${dump} || {
      dropdb ${dbname} 
      false # to force fail...
    }
  } || fail=$((fail+1))
done

echo "Attempted to restore ${dbs} databases, ${fail} failed"
exit $fail
#psql -l
