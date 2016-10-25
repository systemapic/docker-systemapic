### PostGIS backup and restore


##### Backup volume store

Backup volume store can be created with:

`sh
 docker create -v /backup/postgis --name postgis_backup_store systemapic/ubuntu
`

#### Backup

Backups can be taken running

`
  backup/run.sh
`

They will be taken from the `${SYSTEMAPIC_DOMAIN}_postgis_1`
container (expected to be running) and put into the
`postgis_backup_store` container.

#### Restore

Latest backup can be restored into a new store usable
by current systemapic/postgis:latest image running:

`
  restore/run.sh
`

The current store container (`postgresql_store_${SYSTEMAPIC_DOMAIN}`)
will be renamed to have a random suffix (pid of the run.sh process)
and a new one will be created with the data restored.

Restarting service after a successful restore run would be
a way to upgrade PostgreSQL/PostGIS with a full dump/reload process

WARNING: any change occurring in any of the databases after the
         backup/run.sh and before the restart is lost so it is
         recommended to switch the service databases into read-only
         mode during an upgrade
