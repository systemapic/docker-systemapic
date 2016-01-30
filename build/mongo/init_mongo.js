var fs = require('fs');

fs.readFile('/systemapic/config/mongo.json', 'utf-8', function (err, json) {
	if (err) throw err;

	var config = JSON.parse(json);

	// settings
	// var password = 'qHZrRctXdkd2pt5AuexKeDb7Sag55zdRxZw5XUEW';
	// var db_user = 'systemapic';

	var password = config.password;
	var user = config.user;
	var database = config.database || 'systemapic';

	console.log('password:', password);
	console.log('user:', user);

	// prime db for auth
	var admin = connect('localhost:27017/admin');
	admin.system.users.remove({})
	admin.system.version.remove({})
	admin.system.version.insert({ '_id' : 'authSchema', 'currentVersion' : 3 })

	// add user
	var db = connect('localhost:27017/systemapic');
	db.createUser({user : user, pwd: password, roles : [{role : 'root', db: 'admin'}, {role : 'dbOwner', db: database}]})

});