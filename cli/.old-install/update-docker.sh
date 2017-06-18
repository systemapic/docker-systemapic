#!/bin/bash
apt-get update -y && apt-get install -y --only-upgrade docker-ce
docker version