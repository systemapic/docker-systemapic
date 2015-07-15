#!/bin/bash
docker run --name pile --link rkue:rkue --link rtoken:rtoken -p 3003 --volumes-from data_store_dev -d systemapic/pile 