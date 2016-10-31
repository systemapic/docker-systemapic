## Docker Compose

This is the folder in which [Mapic Cloud Server](http://mapic.io)
is run.

## Usage
- To start server and all containers: `./start-mapic.sh`
- To stop all containers : `./stop-mapic.sh`
These scripts are available in the `mapic` root folder.

## Configuration

The `common.yml` file describes services, while domain specific `.yml`
file (eg. `dev.mapic.io.yml`) overrides common and adds specific
stores, environment, etc.

Configurations for containers are mounted from `mapic/config/$MAPIC_DOMAIN/`
folder on the host system, from `common.yml` file. For example:
```yml
redis:
  image: redis:latest
  volumes:
    - ../../config/${MAPIC_DOMAIN}:/mapic/config

```

Thus, each container has available config for its relevant domain in
`/mapic/config` folder (inside container).

Domain will be chosen automatically by checking `MAPIC_DOMAIN`
env variable on host. This ENV must be set.

The `.yml` files decides what runs, which containers are connected
to each other, etc.

For example, if `MAPIC_DOMAIN=dev.mapic.io`, then
`dev.mapic.io.yml` compose setup will be run, and configuration from
`config/dev.mapic.io/` will be used.


## References:
[Docker](http://docker.io/)
[Docker compose](https://docs.docker.com/compose/)
