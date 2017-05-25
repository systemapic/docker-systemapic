#!/bin/bash
WDR=/usr/src/app
docker run -it -p 80:80 -p 443:443 --env-file $MAPIC_ENV_FILE --volume $PWD:$WDR -w $WDR node:4 sh entrypoint.sh