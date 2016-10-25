## Building

You need to pass the PGVER build argument, like:
docker build --build-arg PGVER=9.3

Run `./build.sh` to be prompted for which PostgreSQL version to build (9.4 or 9.3),
or `.build.sh 9.4` to build a version without being prompted.  

Usage: `./build.sh [PGVER]`


## Executing

Standard entrypoint is the './start.sh' script, called with PGVER value
as argument. The script starts PostgreSQL litening on tcp port 5432
after making sure a valid PGDATA directory is found in
/var/lib/postgresql/${PGVER}/main, creating it and initializing it
as needed.

As part of the initialization, if a `SYSTEMAPIC_RESTORE_POSTGIS_FROM`
environment variable is set, the script will attempt to restore
database dumps from the directory specified in its value.

## Contained scripts

All scripts are installed in the root dir of the image filesystem.

In addition to the 'start.sh' script, discussed in the Executing
section, we have:

  - `restore_databases.sh`

    This can be used to restore databases from `db_xxx.dump`
    files found in a given directory.
    The script is used by `start.sh` when SYSTEMAPIC_RESTORE_POSTGIS_FROM
    env is set.

  - `update_extensions.sh`

    This script ensures all required extension are loaded in
    all the databases and the template

