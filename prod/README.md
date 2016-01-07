## Docker Compose

This is where everything is run from.  

`docker-compose.yml` decides what's being run, which containers are connected to each other, etc.  

- To start server and all containers: `./restart.sh`
- To build all containers (given that dependency containers already built): `./build_all.sh`
- To build dependencies (will take at least 20mins to build from scratch): `./build_all_deps.sh`

---
#### References:
[Docker compose](https://docs.docker.com/compose/)