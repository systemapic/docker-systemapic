#!/bin/bash

test -f /var/www/wu/config/server-config.js || {
  echo "ERROR: a /var/www/wu/config/server-config.js file is needed for wu to run" >&2
  exit 1
}

echo -e "\e[93mKilling containers...\e[39m"
docker-compose kill
echo -e "\e[93mDeleting containers...\e[39m"
./delete_containers.sh
echo -e "\e[93mStarting containers...\e[39m"
docker-compose up -d || {
  echo "If missing containers, try ./create_storage_containers.sh"
  exit 1
}
echo -e "\e[93mOpening logs...\e[39m"
docker-compose logs
