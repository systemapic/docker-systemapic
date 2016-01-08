### PostGIS backup

Idea is to run this container with `docker-compose.yml`, and it will periodically dump backups to `/backup/postgis` on `postgis_backup_store` volume.


#### Scripts
`backup_databases.sh` runs the actual backup.


##### Volume store
Created thus: `docker create -v /backup/postgis --name postgis_backup_store systemapic/ubuntu`