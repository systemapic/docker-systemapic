#!/bin/bash
docker run --name vile --rm --link rkue:rkue --link rtoken:rtoken --link mongo:mongo -v /data:/data -v /var/www/vile:/var/www/vile -v /root/.ssh:/root/.ssh -p 3003 -it devv/wu bash
