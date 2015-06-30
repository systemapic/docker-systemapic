#!/bin/bash
docker run --volumes-from mongo_store_dev --name mongo -P -d systemapic/mongo
# docker run -v /var/lib/mongodb:/var/lib/mongodb --name mongo -d systemapic/mongo