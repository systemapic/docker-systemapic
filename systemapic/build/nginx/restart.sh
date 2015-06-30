#!/bin/bash
docker kill nginx
docker rm nginx
sh run.sh