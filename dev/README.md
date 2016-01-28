## Docker Compose

This is where everything is run from.  

There are different servers, so go in respective folder to `./restart.sh` and set `docker-compose.yml` config.

`docker-compose.yml` decides what's being run, which containers are connected to each other, etc.  

- To start server and all containers: `./restart.sh`
- To build all containers: `./build_all.sh`

---
#### References:
[Docker compose](https://docs.docker.com/compose/)
