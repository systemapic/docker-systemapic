### PostGIS backup and restore


#### Backup

A `backup` container is attached in `docker-compose.yml` that will
dump current dbs to `/backup/postgis` on another storage volume
`postgis_backup_store` every midnight.

##### Backup volume store

Created thus: `docker create -v /backup/postgis --name postgis_backup_store systemapic/ubuntu`

#### Restore

Run `./do_restore.sh` in `/restore/`.
Usage `./do_restore.sh <backup_store> <backup_path> <pgdata_store> <postgis_image>`.

This will restore specified backup (<backup_path> in <backup_store>)
into a fresh store (<pgdata_store>) to be used by the specified postgis
image (<postgis_image>, which determines postgresql/postgis version).

The created store can then be swapped in `docker-compose.yml`, togheter
with the referenced postgis image.

