#!/bin/bash
docker run --name nginx --link vile:vile --link wu:wu -p 443:443 -p 80:80 -d systemapic/nginx-server
