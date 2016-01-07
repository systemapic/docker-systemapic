## Docker containers

Our main containers are:
1. wu (image: systemapic/wu)
2. pile (image: systemapic/pile)
3. postgis (image: systemapic/postgis)
4. mongo (image: systemapic/mongo)
5. rediskue (image: systemapic/redis:kue)
6. redislayers (image: systemapic/redis:layers)
7. redisstats (image: systemapic/redis:stats)
8. nginx (image: systemapic/nginx)

They are started with `docker-compose.yml`, in `/dev/`.

Our storage containers are:
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
5. mongo_store_dev
  - used by `mongo`
  - contains the objects stored by the webserver (eg. users, projects, file objects, layer objects, etc.)
  - mounts on `/data/db`
  - created thus: `docker create -v /data/db --name mongo_store_dev systemapic/ubuntu`

All storage is contained in storage containers. That means that the main containers can be stopped, destroyed, recreated, without it affecting the data that's stored. This also means that - in theory - the containers can be moved to another server and the contents of the portal stays the same.

