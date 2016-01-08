### PostGIS backup


#### Backup
A `backup` container is attached in `docker-compose.yml` that will dump current dbs to `/backup/postgis` on another storage volume `postgis_backup_store` every midnight.

#### Restore
Run `./do_restore.sh` in `/restore/`. Usage: `./do_restore.sh <backup_store_name> <backup_store_path> <pgdata_store_name>`. This will restore current backed up store into a fresh store, which can be swapped in `docker-compose.yml`.

##### Volume store
Created thus: `docker create -v /backup/postgis --name postgis_backup_store systemapic/ubuntu`