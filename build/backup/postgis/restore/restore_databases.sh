#!/bin/bash


export PGUSER=docker
export PGPASSWORD=docker 
export PGDATABASE=template1
export PGHOST=localhost
export PGPORT=5432
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

echo "Starting database ... "
./start.sh &
while :; do
	sleep 5;
	psql -c "select version();" && break;
done

echo "Restoring dumps"
for dump in ${BACKUPDIR}/db_*.dump; do
	dbname=`basename $dump .dump | sed 's/^db_//'`
	echo "Creating database ${dbname} ..."
	createdb ${dbname}
	echo "Restoring database ${dbname} ..."
	pg_restore ${dump} | ${PSQL} ${dbname}
done

#psql -l
