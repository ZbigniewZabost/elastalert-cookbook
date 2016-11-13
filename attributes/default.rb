default['elastalert']['repository'] = 'https://github.com/Yelp/elastalert.git'
default['elastalert']['version'] = 'v0.1.3'

default['elastalert']['elasticsearch']['hostname'] = 'localhost'
default['elastalert']['elasticsearch']['port'] = 9200
default['elastalert']['elasticsearch']['index'] = 'elastalert_status'
default['elastalert']['elasticsearch']['index_old'] = ''
default['elastalert']['elasticsearch']['url_prefix'] = ''
default['elastalert']['elasticsearch']['create_index_opts'] = '--no-auth --no-ssl'

default['elastalert']['user'] = 'elastalert'
default['elastalert']['user_home'] = "/home/#{node['elastalert']['user']}"
default['elastalert']['group'] = 'elastalert'
default['elastalert']['directory'] = '/opt/elastalert'
default['elastalert']['virtualenv']['directory'] = "#{node['elastalert']['directory']}/.env"
