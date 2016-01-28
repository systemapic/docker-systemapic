## Docker Compose

This is where everything is run from.  

There are different servers, so go in respective folder to `./restart.sh` and set `docker-compose.yml` config.

`docker-compose.yml` decides what's being run, which containers are connected to each other, etc.  

- To start server and all containers: `./restart.sh`

All docker images will need to be available.

- To build all service images: `./build_all.sh`
- TODO: specify how to build store containers

---
#### References:
[Docker compose](https://docs.docker.com/compose/)
