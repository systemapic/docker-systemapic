// settings
var password = 'qHZrRctXdkd2pt5AuexKeDb7Sag55zdRxZw5XUEW';
var db_user = 'systemapic';

// prime db for auth
var admin = connect('localhost:27017/admin');
admin.system.users.remove({})
admin.system.version.remove({})
admin.system.version.insert({ '_id' : 'authSchema', 'currentVersion' : 3 })

// add user
var db = connect('localhost:27017/systemapic');
db.createUser({user : db_user, pwd: password, roles : [{role : 'root', db: 'admin'}, {role : 'dbOwner', db: 'systemapic'}]})