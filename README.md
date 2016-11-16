# elastalert chef cookbook 
[![Build Status](https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master/build_image)](https://snap-ci.com/zbigniewz/elastalert-cookbook/branch/master) 
Installs and configures [Yelp's elastalert](https://github.com/Yelp/elastalert)

### TODO
* add more platforms (CentOS?)
* test, styling rakefile, CI
* pull up what is possible to attributes

## How to use
Create wrapper around this cookbook and adjust attributes to your needs.

## Recipes
```recipes/default.rb``` - does everything, checksout elastalert, installs it using virtual env and starts using supervisor.

## Attributes
See ```attributes/default.rb``` for list of attributes and it default values.
