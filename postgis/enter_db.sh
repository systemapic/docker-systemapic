#!/bin/bash
export PAGER="/usr/bin/less -S"
export PGPASSWORD=docker 
psql -h 172.17.8.151 --username=docker systemapic