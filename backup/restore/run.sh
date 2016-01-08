#!/bin/bash
docker run -d --name postgis_restore --volumes-from postgis_backup systemapic/postgis:restore
