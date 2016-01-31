## Docker Compose

This is the folder in which everything is built and run.

## Usage
- To build all images: `./build_all.sh`
- To start server and all containers: `./restart.sh`
- To stop all containers : `./kill.sh`

## Configuration
There are compose files for respective domains. 

Configurations for containers are mounted from `/docks/config/$SYSTEMAPIC_DOMAIN/` folder on `localhost`,  
like this: `/docks/config/dev.systemapic.com:/systemapic/config`. Thus, each container will have available config  
for relevant domain in `/systemapic/config` folder (inside container).

Domain will be chosen automatically by checking `SYSTEMAPIC_DOMAIN`
env variable on host. This ENV must be set.

The `.yml` files decides what runs, which containers are connected
to each other, etc.

For example, if `SYSTEMAPIC_DOMAIN=dev.systemapic.com`, then
`dev.systemapic.com.yml` compose setup will be run, and configuration from `/docks/config/dev.systemapic.com/` will be used.

--
## References:
[Docker compose](https://docs.docker.com/compose/)
