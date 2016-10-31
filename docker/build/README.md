## Docker containers

##### Our main containers are:
1. mapic/engine (image: `mapic/engine:latest`)  
2. mapic/mile (image: `mapic/mile:latest`)  
3. postgis (image: `mapic/postgis:latest`)  
4. mongo (image: `mapic/mongo:latest`)  
5. rediskue (image: `redis:latest`)  
6. redislayers (image: `redis:latest`)  
7. redisstats (image: `redis:latest`)  
8. redistokens (image: `redis:latest`)  
9. nginx (image: `mapic/nginx:latest`)  

They are started using `./start-mapic.sh`, in the root folder. `start-mapic.sh` will read `$MAPIC_DOMAIN` env on host, and run corresponding compose file.

All storage containers can be created automatically, based on the stores required in `.yml` file, by running `./create-storage-containers.sh`.

##### Our storage containers are:  
1. data_store_dev_common  
    - used by `engine` and `mile`  
    - contains raster tile png's, vector tiles, uploaded raw files, etc.  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name data_store_dev_common mapic/ubuntu`  
2. postgis_store_dev  
    - used by `postgis`  
    - contains the actual data stored in postgis  
    - mounts on `/var/lib/postgresql`  
    - created thus: `docker create -v /var/lib/postgresql --name postgis_store_dev mapic/ubuntu`  
3. redis_store_dev  
    - used by `redislayers`  
    - contains the layers that are used by the tileserver  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name redis_store_dev mapic/ubuntu`  
4. redis_stats_store_dev  
    - used by `redisstats`  
    - contains stats  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name redis_stats_store_dev mapic/ubuntu`  
5. redis_tokens_store_dev  
    - used by `redistokens`  
    - contains access tokens  
    - mounts on `/data`  
    - created thus: `docker create -v /data --name redis_tokens_store_dev mapic/ubuntu`  
6. mongo_store_dev  
    - used by `mongo`  
    - contains the objects stored by the webserver (eg. users, projects, file objects, layer objects, etc.)  
    - mounts on `/data/db`  
    - created thus: `docker create -v /data/db --name mongo_store_dev mapic/ubuntu`  

All storage is contained in storage containers. That means that the main containers can be stopped, destroyed, recreated, without it affecting the data that's stored. This also means that - in theory - the containers can be moved to another server and the contents of the portal will be moved also.

