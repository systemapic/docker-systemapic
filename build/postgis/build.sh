#!/bin/bash
docker build --build-arg PGVER=9.3 -t systemapic/postgis .
