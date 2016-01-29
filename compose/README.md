## Docker Compose

This is where everything is run from.  

There are configurations for different domains here.

Domain will be chosen automatically by checking `$SYSTEMAPIC_DOMAIN` env variable on host. This ENV must be set.

The `.yml` files decides what's being run, which containers are connected to each other, etc. 

- To start server and all containers: `./restart.sh`

All docker images will need to be available.

- To build all service images: `./build_all.sh`

---
#### References:
[Docker compose](https://docs.docker.com/compose/)
