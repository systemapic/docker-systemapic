var pg = require('pg').native;
var exec = require('child_process').exec;

var pg_username = 'docker';
var pg_password = 'docker';
var pg_host = '172.17.8.151';
var pg_db = 'systemapic';

// var conString = "postgres://docker:docker@172.17.8.151/systemapic";

var conString = 'postgres://' + pg_username + ':' + pg_password + '@' + pg_host + '/' + pg_db;

console.log('conString: ', conString);

// var shapefile_path = '/docks/postgis/docker-postgis/testdata/africa/Africa.shp';
var shapefile_folder = '/docks/postgis/docker-postgis/testdata/';
var shapefile_file = 'cetin5/cetin3_SBAS_6x5_22d-sbas-direct_UTM38N_Coherence_0.2.shp';
var shapefile_path = shapefile_folder + shapefile_file;
var fileUuid = 'cetin_Coherence';


// var cmd = 'shp2pgsql -I egypt/EGY-level_1.shp file-322323-232332 | PGPASSWORD=docker psql -h 172.17.8.151 --username=docker systemapic'
var cmd = [
	'shp2pgsql',
	'-I',
	shapefile_path,
	fileUuid,
	'|',
	'PGPASSWORD=docker',
	'psql',
	'-h 172.17.8.151',
	'--username=docker',
	'systemapic'
]

var command = cmd.join(' ');
console.log('command: ', command);

console.time('import');
exec(command, {maxBuffer: 1024 * 50000}, function (err, stdin, stdout) {
	console.log('cmd done', stdout, stdin, err);
	console.timeEnd('import');
});

// pg.connect(conString, function(err, client, done) {
// 	if (err)  return console.error('error fetching client from pool', err);

// 	console.log('err:', err);
// 	console.log('client:', client);

// 	var sql = 'SELECT $1::int AS number';
// 	var sql = 'SELECT * FROM dev_portal';

// 	var query = client.query(sql);
// 	console.log('query: ', query);
// 	query.on('row', function(row) {
// 		// console.log(row);
// 		console.log(row.country, row.id);
// 	});
// 	query.on('error', function(error) {
// 		//handle the error
// 		console.log('ERROR', error);
// 	});
// });