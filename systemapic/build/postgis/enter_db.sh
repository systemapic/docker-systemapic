#!/bin/bash
export PAGER="/usr/bin/less -S"
export PGPASSWORD=docker 
psql -h 172.17.9.159 --username=docker systemapic