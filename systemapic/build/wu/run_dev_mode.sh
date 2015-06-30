#!/bin/bash
docker run --name wu --rm --link rkue:rkue --link rtoken:rtoken --link mongo:mongo -v /data:/data -v /var/www/wu:/var/www/wu -v /root/.ssh:/root/.ssh -p 3001 -it devv/wu bash
