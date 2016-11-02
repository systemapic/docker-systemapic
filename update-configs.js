var fs = require("fs");
var crypto = require("crypto");

var MONGO_JSON_PATH = __dirname + "/config/localhost/mongo.json";
var MILE_CONFIG_PATH = __dirname + "/config/localhost/mile.config.js";
var ENGINE_CONFIG_PATH = __dirname + "/config/localhost/engine.config.js";
var REDIS_LAYERS_CONF_PATH = __dirname + "/config/localhost/redis.layers.conf";
var REDIS_STATS_CONF_PATH = __dirname + "/config/localhost/redis.stats.conf";
var REDIS_TOKENS_CONF_PATH = __dirname + "/config/localhost/redis.tokens.conf";
var REDIS_TEMP_CONF_PATH = __dirname + "/config/localhost/redis.temp.conf";

var passString = crypto.randomBytes(64).toString('hex');

var updateRedisConfig = function (filePath) {
    var lines = fs.readFileSync(filePath).toString().split("\n");
    for(var i in lines) {
        var lineText = lines[i];
        if(lineText.indexOf('requirepass') > -1){
            lines[i] = "requirepass " + passString;
            break;
        }
    }

    lines = lines.join('\n');
    fs.writeFileSync(filePath, lines, 'utf-8');  
};


console.log("Updating mongo.json File...");

var content = fs.readFileSync(MONGO_JSON_PATH);// Read Synchrously

var data = JSON.parse(content);
data.password = passString;
fs.writeFileSync(MONGO_JSON_PATH, JSON.stringify(data, null, 2) , 'utf-8');


console.log("Updating mile-config.js File...");

var mileConfig = require(MILE_CONFIG_PATH);

mileConfig.redis.layers.auth = passString;
mileConfig.redis.stats.auth = passString;
mileConfig.redis.temp.auth = passString;

var mileJsonStr = 'module.exports = ' + JSON.stringify(mileConfig, null, 2);
fs.writeFileSync(MILE_CONFIG_PATH, mileJsonStr , 'utf-8');


console.log("Updating engine-config.js File...");

var engineConfig = require(ENGINE_CONFIG_PATH);

engineConfig.serverConfig.mongo.url =  "mongodb://systemapic:" + passString + "@mongo/systemapic";

engineConfig.serverConfig.redis.layers.auth = passString;
engineConfig.serverConfig.redis.stats.auth = passString;
engineConfig.serverConfig.redis.temp.auth = passString;

var engineJsonStr = 'module.exports = ' + JSON.stringify(engineConfig, null, 2);
var content = fs.readFileSync(ENGINE_CONFIG_PATH);
content = content.toString('utf8');
fs.writeFileSync(ENGINE_CONFIG_PATH , engineJsonStr, 'utf-8');


console.log("Updating redis.layers.conf File...");
updateRedisConfig(REDIS_LAYERS_CONF_PATH);


console.log("Updating redis.stats.conf File...");
updateRedisConfig(REDIS_STATS_CONF_PATH);


console.log("Updating redis.tokens.conf File...");
updateRedisConfig(REDIS_TOKENS_CONF_PATH);


console.log("Updating redis.temp.conf File...");
updateRedisConfig(REDIS_TEMP_CONF_PATH);

