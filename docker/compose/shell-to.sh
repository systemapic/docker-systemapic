#!/bin/bash

function abort() {
	echo $1
	exit 1;
}

test -n "$1" || abort "Usage: $0 <name>"
NAME=$1

# check SYSTEMAPIC_DOMAIN is set
test -z "$SYSTEMAPIC_DOMAIN" &&
  abort "Usage: $0 <domain> (or set SYSTEMAPIC_DOMAIN ENV variable, eg. export SYSTEMAPIC_DOMAIN=localhost)"

PREFIX=`echo ${SYSTEMAPIC_DOMAIN} | sed 's/\..*//'`
FULLNAME=${PREFIX}_${NAME}_1
docker exec -ti ${FULLNAME} bash
