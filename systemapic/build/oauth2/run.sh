#!/bin/bash

# 			link to dev/compose 	external ip	 use local repo			     image 	    bash
CMD="docker run -it --link dev_mongo_1:mongo -p 3000:3000 -v /var/www/oauth2:/var/www/oauth2 --rm systemapic/oauth2 bash"
echo $CMD
$CMD