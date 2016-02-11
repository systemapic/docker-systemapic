#!/bin/bash

DEFAULT_PGVER=9.3

PGVER=$DEFAULT_PGVER
test -n "$1" && PGVER=$1

cd common
./build.sh $PGVER || abort "Building PostgreSQL failed!"
