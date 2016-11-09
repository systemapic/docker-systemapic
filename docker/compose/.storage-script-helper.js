#!/usr/bin/env node
//
// Creates a bash script which will create correct storage containers
//


// install node modules
var exec = require('child_process').exec;
var child = exec('npm install lodash yamljs async', function (err, stdout, stderr) {
    if (err) console.log('exec error: ' + err);

    // deps
    var _ = require('lodash');
    var YAML = require('yamljs');
    var async = require('async');
    var exec = require('child_process').exec;
    var fs = require('fs');

    // load file
    var MAPIC_DOMAIN = process.env.MAPIC_DOMAIN || 'localhost';
    var yml_file = YAML.load('yml/' + MAPIC_DOMAIN + '.yml');

    // store 
    var parsed = {};

    // settings
    var paths = {
        engine      : '/data',
        mile        : '/data',
        redisstats  : '/data',
        redislayers : '/data',
        redistokens : '/data',
        mongo       : '/data/db',
        postgis     : '/var/lib/postgresql',
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

    var bash_script = '#!/bin/bash \n';
    commands.forEach(function (c) {
        bash_script += c + '\n';
    });

    fs.writeFileSync('createcontainers.tmp.sh', bash_script, 'utf-8');
});
