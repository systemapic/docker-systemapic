#!/bin/bash
echo 'Creating Strong Diffie-Hellmann Group'
openssl dhparam -out dhparams.pem 2048
docker build -t systemapic/nginx .
