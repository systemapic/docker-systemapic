#!/bin/bash

fail () {
    echo "Error: $1  Ensure Mapic is running!"
    exit 1;
}

# create user
mapic run engine node --no-deprecation scripts/create_user.js "$@" || fail
