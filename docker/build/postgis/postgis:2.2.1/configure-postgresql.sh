#!/bin/bash

PGVER=9.3
PGVER_SHORT=93

# configure access
echo "host    all             all             0.0.0.0/0 md5" >> /etc/postgresql/${PGVER}/main/pg_hba.conf

# configure postgresql
echo "listen_addresses = '*'" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "port = 5432" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "log_statement = ddl" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "log_statement = none" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "log_statement = all" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "log_min_error_statement = ERROR" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "log_line_prefix = '%t %a [%p-%l] %q%u@%d '" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "ssl = false" >> /etc/postgresql/${PGVER}/main/postgresql.conf

# pgtune
echo "max_connections = 100" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "shared_buffers = 4GB" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "effective_cache_size = 12GB" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "work_mem = 20971kB" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "maintenance_work_mem = 2GB" >> /etc/postgresql/${PGVER}/main/postgresql.conf
if test ${PGVER_SHORT} -lt 95; then 
  echo "checkpoint_segments = 128" >> /etc/postgresql/${PGVER}/main/postgresql.conf
fi
echo "checkpoint_completion_target = 0.9" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "wal_buffers = 16MB" >> /etc/postgresql/${PGVER}/main/postgresql.conf
echo "default_statistics_target = 500" >> /etc/postgresql/${PGVER}/main/postgresql.conf


# restart for config flush
service postgresql start && service postgresql stop