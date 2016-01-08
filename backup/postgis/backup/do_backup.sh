#!/bin/bash

BASEOUTDIR=/backup/postgis/
BACKUPNAME=postgis-backup-`date +%w` # use day of week
OUTDIR=${BASEOUTDIR}/${BACKUPNAME}

mkdir -p "${BASEOUTDIR}" || exit 1
cd ${BASEOUTDIR}

sh /tmp/backup_databases.sh ${BACKUPNAME}-inprogress || exit 1

rm -rf ${BACKUPNAME} && mv ${BACKUPNAME}-inprogress ${BACKUPNAME}
ln -fs ${BACKUPNAME} postgis-backup-last
