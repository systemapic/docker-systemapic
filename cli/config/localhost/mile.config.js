module.exports = {
  "port": 3003,
  "redis": {
    "layers": {
      "port": 6379,
      "host": "redislayers",
      "auth": "8a7b3a55a9bbef40997d81bca7e3ba1878b9179d97e782224cce8c631f4ba59dc42d48857be6450ff8133d40913df75b5cd46ac3c63e91f0eeec5b9e3f8388db",
      "db": 2
    },
    "stats": {
      "port": 6379,
      "host": "redisstats",
      "auth": "8a7b3a55a9bbef40997d81bca7e3ba1878b9179d97e782224cce8c631f4ba59dc42d48857be6450ff8133d40913df75b5cd46ac3c63e91f0eeec5b9e3f8388db",
      "db": 2
    },
    "temp": {
      "port": 6379,
      "host": "redistemp",
      "auth": "8a7b3a55a9bbef40997d81bca7e3ba1878b9179d97e782224cce8c631f4ba59dc42d48857be6450ff8133d40913df75b5cd46ac3c63e91f0eeec5b9e3f8388db",
      "db": 2
    }
  },
  "mongo": {
    "url": "mongodb://mongo/mapic"
  },
  "path": {
    "log": "/data/logs/"
  },
  "noAccessMessage": "No access. Please contact Systemapic.com if you believe you are getting this message in error.",
  "noAccessTile": "public/noAccessTile.png",
  "processingTile": "public/noAccessTile.png",
  "defaultStylesheets": {
    "raster": "public/cartoid.xml",
    "utfgrid": "public/utfgrid.xml"
  }
}