#!/bin/bash

BASEOUTDIR=/backup/postgis/
BACKUPNAME=postgis-backup-`date +%w` # use day of week
OUTDIR=${BASEOUTDIR}/${BACKUPNAME}

mkdir -p "${BASEOUTDIR}" || exit 1

if test -e "${OUTDIR}"; then
	echo "NOTICE: output dir already exist, will delete it!"
  rm -r $OUTDIR
fi

sh /tmp/backup_databases.sh $OUTDIR || exit 1
cd ${BASEOUTDIR}
rm -f postgis-backup-last
ln -s ${BACKUPNAME} postgis-backup-last
