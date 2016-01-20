#!/bin/bash

PASS=bigsecret
USER=systemapic

# need to setup admin for secure access

# 1. start mongodb without auth
# 2. add admin/user with pass
# 3. restart mongo with auth config


mongod -f /etc/mongod.conf &

mongo --eval "use admin"
mongo --eval "db.system.users.remove({})"
mongo --eval "db.system.version.remove({})"
mongo --eval "db.system.version.insert({ '_id' : 'authSchema', 'currentVersion' : 3 })"

mongo --eval "use systemapic"
mongo --eval "db.createUser({user : 'systemapic', pwd: 'pwd', roles : [{role : 'root', db: 'admin'}, {role : 'dbOwner', db: 'systemapic'}]})"

kill $1

mongod -f /etc/mongod.conf --auth &

mongo --eval "db.runCommand({connectionStatus : 1})"

kill $1

echo done