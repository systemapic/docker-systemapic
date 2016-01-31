var fs = require('fs');

var configFile = '/systemapic/config/mongo.json';

// read config
fs.readFile(configFile, 'utf-8', function (err, json) {
	if (err) throw err;

	// parse config
	var config = JSON.parse(json);
	var password = config.password;
	var user = config.user;
	var database = config.database || 'systemapic';

	// prime db for auth
	var admin = connect('localhost:27017/admin');
	admin.system.users.remove({})
	admin.system.version.remove({})
	admin.system.version.insert({ '_id' : 'authSchema', 'currentVersion' : 3 })

	// add user
	var db = connect('localhost:27017/systemapic');
	db.createUser({user : user, pwd: password, roles : [{role : 'root', db: 'admin'}, {role : 'dbOwner', db: database}]})

});