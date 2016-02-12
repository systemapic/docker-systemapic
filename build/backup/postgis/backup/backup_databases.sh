#!/bin/bash
#export PAGER="/usr/bin/less -S"

source /systemapic/config/env.sh || exit 1

export PGUSER=$SYSTEMAPIC_PGSQL_USERNAME
export PGPASSWORD=$SYSTEMAPIC_PGSQL_PASSWORD
export PGDATABASE=template1
export PGHOST=postgis

if test -z "${PGHOST}"; then
	echo -n "Enter postgis ip or hostname (no PGHOST env found): "
	read PGHOST
fi

if test -z "$1"; then
	echo "Usage: $0 <outdir>" >&2
	exit 1
fi

OUTDIR="$1"
if test -e "${OUTDIR}"; then
	echo "Output dir already exist, will not proceed" >&2
	exit 1
fi

echo "Backing up PostGIS to ${OUTDIR}..."


mkdir -p "${OUTDIR}" || exit 1

cd "${OUTDIR}" || exit 1
echo "Dumping globals ..."
pg_dumpall -g > _globals.dump || exit 1
psql -XAtc "select datname from pg_catalog.pg_database where not datistemplate" |
while read DB; do
	echo "Dumping database ${DB} ..."
	pg_dump -Fc ${DB} > "db_${DB}.dump" || {
		echo "Something went wrong" >&2;
		exit 1
	}
done
echo "All cluster dumped in '${OUTDIR}'"
#psql -h postgis --username=docker systemapic
