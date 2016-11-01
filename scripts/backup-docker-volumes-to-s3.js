#!/usr/bin/env node

// script for backup up containers to Amazon S3

// deps
var _ = require('lodash');
var YAML = require('yamljs');
var async = require('async');
var exec = require('child_process').exec;
var fs = require('fs');

// get env
var MAPIC_DOMAIN = process.env.MAPIC_DOMAIN || 'localhost';

// aws credentials
var aws_config = fs.readFileSync('aws.ignore.json', 'utf8');
var config = JSON.parse(aws_config)
var AWS_ACCESS_KEY_ID = config.AWS_ACCESS_KEY_ID;
var AWS_SECRET_ACCESS_KEY = config.AWS_SECRET_ACCESS_KEY; 
var AWS_DEFAULT_REGION = config.AWS_DEFAULT_REGION || 'eu-west-1';
var AWS_BUCKET_NAME = config.AWS_BUCKET_BASE_NAME + '/' + MAPIC_DOMAIN;
var RESTORE = 'false';

if (!AWS_ACCESS_KEY_ID || !AWS_ACCESS_KEY_ID) return console.log('Please add your Amazon credentials.');

// settings
var container_paths = {
    engine : '/data',
    mile : '/data',
    redisstats : '/data',
    redislayers : '/data',
    redistokens : '/data',
    mongo : '/data/db',
    postgis : '/var/lib/postgresql',
}

// read yml file
var yml_file_path = '../docker/compose/yml/' + MAPIC_DOMAIN + '.yml';
var yml_file = YAML.load(yml_file_path);
if (!yml_file) return console.log('No such YAML file:', yml_file_path);

// parse yml
var parsed = {};
var temp = [];
_.each(yml_file, function (value, key) {
    if (value.volumes_from) {
        var vol = value.volumes_from[0];
        if (!_.includes(temp, vol)) {
            temp.push(vol)
            parsed[key] = value.volumes_from[0];
        }
    }
});

// create commands
var commands = [];
_.each(parsed, function (storage_container, service_name) {

    var command = [
        'docker',
        'run',
        '--rm',
        '--env',
        'AWS_ACCESS_KEY_ID=' + AWS_ACCESS_KEY_ID,
        '--env',
        'AWS_SECRET_ACCESS_KEY=' + AWS_SECRET_ACCESS_KEY,
        '--env',
        'AWS_DEFAULT_REGION=' + AWS_DEFAULT_REGION,
        '--env',
        'S3_BUCKET_NAME=' + AWS_BUCKET_NAME,
        '--env',
        'BACKUP_NAME=' + storage_container,
        '--env',
        'PATHS_TO_BACKUP=' + container_paths[service_name],
        '--env',
        'RESTORE=' + RESTORE,
        '--volumes-from',
        storage_container,
        '--name', 
        'dockup',
        'tutum/dockup:latest'
    ].join(' ');  

    commands.push({
        cmd : command,
        container : storage_container
    });
});


// run ops
async.eachSeries(commands, function (item, callback) {

    console.log('Backing up', item.container);

    // run docker commands
    exec(item.cmd, function (err, stdout) {
        if (err) console.log('Error: ', err);
        console.log(stdout);
        callback(null);
    });

}, function (err, result) {
    console.log('All containers backed up for', MAPIC_DOMAIN, 'and pushed to Amazon S3!');
});


