#!/bin/bash
docker run --name wu --link rkue:rkue --link rtoken:rtoken --link mongo:mongo -p 3001 --volumes-from data_store_dev -d systemapic/wu
