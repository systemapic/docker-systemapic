#!/bin/bash

# localhost tests
docker exec -it localhost_mile_1 npm test
docker exec -it localhost_engine_1 npm test
docker exec -it localhost_engine_1 npm test
