#!/usr/bin/env node

// deps
var _ = require('lodash');
var YAML = require('yamljs');
var async = require('async');
var exec = require('child_process').exec;

// load file
var MAPIC_DOMAIN = process.env.MAPIC_DOMAIN || 'localhost';
var yml_file = YAML.load('yml/' + MAPIC_DOMAIN + '.yml');

// store 
var parsed = {};

// settings
var paths = {
        engine : '/data',
        mile : '/data',
        redisstats : '/data',
        redislayers : '/data',
        redistokens : '/data',
        mongo : '/data/db',
        postgis : '/var/lib/postgresql',
}

// parse
_.each(yml_file, function (value, key) {
    if (value.volumes_from) {
        parsed[key] = value.volumes_from[0];
    }
});

// create commands
var commands = [];
_.each(parsed, function (name, service) {
    var docker_command = [
        'docker', 
        'create', 
        '-v', 
        paths[service],
        '--name', 
        name,
        'mapic/ubuntu'
    ].join(' ');
    commands.push(docker_command);
});

// run ops
async.eachSeries(commands, function (item, callback) {

    // run docker commands
    exec(item, function (err, stdout) {
        callback(null);
    })

}, function (err, result) {
    console.log('# Storage containers validated @ ' + MAPIC_DOMAIN);
});



