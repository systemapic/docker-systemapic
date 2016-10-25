## Docker containers

##### Our main containers are:
1. wu (image: `systemapic/wu:latest`)  
2. pile (image: `systemapic/pile:latest`)  
3. postgis (image: `systemapic/postgis:latest`)  
4. mongo (image: `systemapic/mongo:latest`)  
5. rediskue (image: `redis:latest`)  
6. redislayers (image: `redis:latest`)  
7. redisstats (image: `redis:latest`)  
8. redistokens (image: `redis:latest`)  
9. nginx (image: `systemapic/nginx:latest`)  
10. backup (image: `systemapic/backup:postgis`)  

They are started using `./restart.sh`, in `/docks/compose/`. `restart.sh` will read `$SYSTEMAPIC_DOMAIN` env on host, and run corresponding compose file.

All storage containers can be created automatically, based on the stores required in `.yml` file, by running `./create_storage_containers.sh`.

##### Our storage containers are:  
1. data_store_dev_common  
    - used by `wu` and `pile`  
    - contains raster tile png's, vector tiles, uploaded raw files, etc.  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name data_store_dev_common systemapic/ubuntu`  
2. postgis_store_dev  
    - used by `postgis`  
    - contains the actual data stored in postgis  
    - mounts on `/var/lib/postgresql`  
    - created thus: `docker create -v /var/lib/postgresql --name postgis_store_dev systemapic/ubuntu`  
3. redis_store_dev  
    - used by `redislayers`  
    - contains the layers that are used by the tileserver  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name redis_store_dev systemapic/ubuntu`  
4. redis_stats_store_dev  
    - used by `redisstats`  
    - contains stats  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name redis_stats_store_dev systemapic/ubuntu`  
5. redis_tokens_store_dev  
    - used by `redistokens`  
    - contains access tokens  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name redis_tokens_store_dev systemapic/ubuntu`  
6. mongo_store_dev  
    - used by `mongo`  
    - contains the objects stored by the webserver (eg. users, projects, file objects, layer objects, etc.)  
    - mounts on `/data/db`  
    - created thus: `docker create -v /data/db --name mongo_store_dev systemapic/ubuntu`  
7. postgis_backup_store  
    - used by `backup`  
    - contains a backup dump of `postgis_store_dev`  
    - mounts on `/backup/postgis`  
    - created thus: `docker create -v /backup/postgis --name postgis_backup_store systemapic/ubuntu`  

All storage is contained in storage containers. That means that the main containers can be stopped, destroyed, recreated, without it affecting the data that's stored. This also means that - in theory - the containers can be moved to another server and the contents of the portal will be moved also.

