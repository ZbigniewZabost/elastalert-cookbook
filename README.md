# Elastalert cookbook
[![Build Status](https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master/build_image)](https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master)

This chef cookbook installs and configures [Yelp's elastalert](https://github.com/Yelp/elastalert).

In more details, this cookbook:
- checks out elastalert github repo using given commit hash or tag
- create elastalert user and group
- installs elastalert in python virtual environment
- creates elastalert index in Elasticsearch
- starts elastalert service with supervisor
- manages elastalert rules

### How to use
Create wrapper around this cookbook and adjust attributes to your needs.

#### Remains to do
* write docs on attributes and usage
* add more platforms (CentOS?)
* get some more badges ;)
* add stove
* publish to chef supermarket


### Recipes
```recipes/default.rb``` - does everything, checksout elastalert, installs it using virtual env and starts using supervisor.

### Attributes
See ```attributes/default.rb``` for list of attributes and it default values.

## Contributing
Fork repo and create pull request, all comments and feedback are welcome!
