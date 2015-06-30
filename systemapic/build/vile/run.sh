#!/bin/bash
docker run --name vile --link rkue:rkue --link rtoken:rtoken -p 3003 --volumes-from data_store_dev -d systemapic/vile 