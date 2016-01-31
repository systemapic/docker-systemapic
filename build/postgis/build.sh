#!/bin/bash

function build() {
  ./common/build.sh $PGVER
}

DEFAULT_PGVER=9.4
PGVER=$1

# prompt version if not specified like `./build.sh 9.3`
if test "$PGVER" = ""; then
  echo "Usage: ./build.sh [PGVER] (like: ./build.sh 9.4)"
  echo ""
  read -e -p "Enter PostgreSQL version to build: [$DEFAULT_PGVER] " PGVER
fi

# set default PGVER
if test "$PGVER" = ""; then PGVER=$DEFAULT_PGVER; fi

# only match supported versions
if [ "$PGVER" = "9.4" ] || [ "$PGVER" = "9.3" ]; then
  build
else
  echo "Build support only for either 9.4 or 9.3. Quitting!"
  exit 1
fi
