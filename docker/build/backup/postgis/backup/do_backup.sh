#!/bin/bash

BASEOUTDIR=/backup/postgis
BACKUPNAME=postgis-backup-`date +%w` # use day of week
OUTDIR=${BASEOUTDIR}/${BACKUPNAME}

mkdir -p "${BASEOUTDIR}" || exit 1
cd ${BASEOUTDIR}

cleanup()
{
  echo 'Cleaning up'
  rm -rf ${BACKUPNAME}-inprogress
}

abort()
{
  exit 1
}

trap 'cleanup' EXIT

bash /tmp/backup_databases.sh ${BACKUPNAME}-inprogress || abort

rm -rf ${BACKUPNAME} &&
  mv ${BACKUPNAME}-inprogress ${BACKUPNAME} &&
  rm -f postgis-backup-last &&
  ln -s ${BACKUPNAME} postgis-backup-last

echo "Backup dir: ${BASEOUTDIR}/${BACKUPNAME} (aka ${BASEOUTDIR}/postgis-backup-last)"
