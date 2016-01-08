#!/bin/bash

OUTDIR=/backup/postgis

if test -e "${OUTDIR}"; then
	echo "Output dir already exist, will delete it!" >&2
	
	rm -rf $OUTDIR
fi

sh /tmp/backup_databases.sh $OUTDIR