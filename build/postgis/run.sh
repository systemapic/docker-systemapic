#!/bin/bash
docker run -d --name postgis --volumes-from postgis_store_dev systemapic/postgis:latest
