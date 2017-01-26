## MongoDB store
Used for models in web-server (`engine`), storing ie. users, projects, layers, etc.

`AUTH` and general configurations are stored in `/mapic/config/$MAPIC_DOMAIN/` folder in `mongo.json` and `mongod.conf`.

On first run, `init_mongo.js` script is run, enabling `AUTH` on MongoDB.