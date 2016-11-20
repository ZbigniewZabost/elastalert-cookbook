# Elastalert cookbook
[![Build Status](https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master/build_image)](https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master)
[![Code Climate](https://codeclimate.com/github/zbigniewz/elastalert-cookbook/badges/gpa.svg)](https://codeclimate.com/github/zbigniewz/elastalert-cookbook)
[![Cookbook Version](https://img.shields.io/cookbook/v/elastalert.svg)](https://community.opscode.com/cookbooks/elastalert)
[![GitHub license](https://img.shields.io/badge/license-Apache%202-blue.svg)](https://raw.githubusercontent.com/zbigniewz/elastalert-cookbook/master/LICENSE)

## Overview
This chef cookbook installs and configures [Yelp's elastalert](https://github.com/Yelp/elastalert).

In more details:
- checks out elastalert github repo using given commit hash or tag
- create elastalert user and group
- installs elastalert in python virtual environment
- creates elastalert index in Elasticsearch
- starts elastalert service with supervisor
- manages elastalert rules

## Requirements

### Platforms
* Debian 8

### Cookbooks
* poise-python
* git
* managed_directory
* supervisor

### Other
* access to Elasticsearch cluster in version needed by particular version of elastalert (default 2.*)

## How to use
Create wrapper around this cookbook and adjust attributes to your needs.

### Attributes
* `node['elastalert']['repository']` - git repository of elastalert, default `https://github.com/Yelp/elastalert.git`
* `node['elastalert']['version']` - commit hash or tag to checkout from elastalert git repo, default `v0.1.3`
* `node['elastalert']['elasticsearch']['hostname']` - hostname of elasticsearch to use, default `localhost`
* `node['elastalert']['elasticsearch']['port']` - port of elasticsearch to use, default `9200`
* `node['elastalert']['elasticsearch']['index']` - name of index to be created by elastalert, default `elastalert_status`
* `node['elastalert']['elasticsearch']['index_old']` - old / previous elastalert index, default empty
* `node['elastalert']['elasticsearch']['url_prefix']` - prefix for Elasticsearch URl (see [Elastalert docs](http://elastalert.readthedocs.io/en/latest/elastalert.html)), default empty
* `node['elastalert']['elasticsearch']['create_index_opts']` - additional options for creating elastalert index (see [Elastalert docs](http://elastalert.readthedocs.io/en/latest/elastalert.html)), default `--no-auth --no-ssl`
* `node['elastalert']['group']` - name of group for user running elastalert, default `elastalert`
* `node['elastalert']['user']` - name of user running elastalert, default `elastalert`
* `node['elastalert']['user_home']` - home directory for user running elastalert, default `/home/elastalert`
* `node['elastalert']['directory']` - installation directory of elastalert, default `/opt/elastalert`
* `node['elastalert']['rules_directory']` - directory containing elastalert rules, default `/opt/elastalert/rules`
* `node['elastalert']['virtualenv']['directory']` - directory for python virtual environment running elastalert, default `/opt/elastalert/.env`
* `node['elastalert']['log_dir']` - logging directory for elastalert, default `/var/log/elastalert`
* `node['elastalert']['supervisor']['logfile']` - stdout log file path for supervisor, default `/var/log/elastalert/elastalert_supervisord.log`
* `node['elastalert']['supervisor']['logfile_maxbytes']` - max size of supervisor stdout log file, default `1MB`
* `node['elastalert']['supervisor']['logfile_backups']` - no. of stdout log file backups, default `2`
* `node['elastalert']['supervisor']['err_logfile']` - stderr log file path for supervisor, default `/var/log/elastalert/elastalert_stderr.log`
* `node['elastalert']['supervisor']['err_logfile_maxbytes']` - max size of supervisor stderr log file, default `5MB`
* `node['elastalert']['supervisor']['run_command']` - supervisor run command starting elastalert (see [Elastalert docs](http://elastalert.readthedocs.io/en/latest/elastalert.html)), default `/opt/elastalert/.env/bin/elastalert --config /opt/elastalert/config.yml --verbose`

### Recipes
```recipes/default.rb``` - does everything.

## Testing
Tested with cookstyle, foodcritic, chefspec and kitchen tests using docker driver, build automatically
on snap ci -> https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master

## Contributing
Fork repo and create pull request, all comments and feedback are welcome!
