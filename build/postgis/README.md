# Building

You need to pass the PGVER build argument, like:
docker build --build-arg PGVER=9.3

# Executing

Standard entrypoint is the ./start.sh script, called with PGVER value
as argument. The script starts PostgreSQL litening on tcp port 5432
after making sure a valid PGDATA directory is found in
/var/lib/postgresql/${PGVER}/main, creating it an initializing it
as needed.

As part of the initialization, if a `SYSTEMAPIC_RESTORE_POSTGIS_FROM`
environment variable is set, the script will attempt to restore
database dumps from the directory specified in its value.

