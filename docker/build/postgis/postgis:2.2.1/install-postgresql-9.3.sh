#!/bin/bash

PGVER=9.3

# update repo
wget --quiet --no-check-certificate -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list
locale-gen --no-purge en_US.UTF-8
LC_ALL en_US.UTF-8
update-locale LANG=en_US.UTF-8

# install
apt-get -y update && apt-get install -y \
  postgresql-contrib-${PGVER} \
  postgresql-${PGVER} \
  postgresql-${PGVER}-postgis-2.2 \
  postgresql-server-dev-${PGVER} \
  libpq-dev
