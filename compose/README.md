## Docker Compose

This is where everything is run from.  

There are configurations for different domains here.

Domain will be chosen automatically by checking `$SYSTEMAPIC_DOMAIN` env variable on host. This ENV must be set.

The `.yml` files decides what's being run, which containers are connected to each other, etc. 

For example, if $SYSTEMAPIC_DOMAIN=dev.systemapic.com, then `dev.systemapic.com.yml` compose setup will be run.

- To build all images: `./build_all.sh`
- To start server and all containers: `./restart.sh`

---
#### References:
[Docker compose](https://docs.docker.com/compose/)
