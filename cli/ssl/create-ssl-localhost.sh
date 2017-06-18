#!/bin/bash

# create certs
openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
openssl req -new -key server.key -out server.csr
openssl x509 -req -sha256 -days 365 -in server.csr -signkey server.key -out server.crt

# rename
mv server.key ssl_certificate.key
mv server.crt ssl_certificate.pem

# cleanup
rm server.key
rm server.csr
rm server.pass.key
rm server.crt