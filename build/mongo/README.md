## MongoDB store
Used for models in web-server (`wu`), storing ie. users, projects, layers, etc.

`AUTH` and general configurations are stored in `/docks/config/$SYSTEMAPIC_DOMAIN/` folder in `mongo.json` and `mongod.conf`.

On first run, `init_mongo.js` script is run, enabling `AUTH` on MongoDB.