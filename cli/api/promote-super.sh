#!/bin/bash

fail () {
    echo "Error: $1  Ensure Mapic is running!"
    exit 1;
}

# promote super
mapic run engine node --no-deprecation scripts/make_super.js $1 || fail
