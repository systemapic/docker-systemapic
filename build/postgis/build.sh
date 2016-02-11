#!/bin/bash

function build() {
  ./common/build.sh $PGVER || abort "Building PostgreSQL failed!"
}

DEFAULT_PGVER=9.3

PGVER=$DEFAULT_PGVER
test -n "$1" && PGVER=$1

build
