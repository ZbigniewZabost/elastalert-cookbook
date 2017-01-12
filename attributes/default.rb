default['elastalert']['version'] = nil

default['elastalert']['elasticsearch']['hostname'] = 'localhost'
default['elastalert']['elasticsearch']['port'] = 9200
default['elastalert']['elasticsearch']['index'] = 'elastalert_status'
default['elastalert']['elasticsearch']['index_old'] = ''
default['elastalert']['elasticsearch']['url_prefix'] = ''
default['elastalert']['elasticsearch']['create_index_opts'] = '--no-auth --no-ssl'
default['elastalert']['elasticsearch']['run_every']['unit'] = 'minutes'
default['elastalert']['elasticsearch']['run_every']['value'] = 1
default['elastalert']['elasticsearch']['buffer_time']['unit'] = 'minutes'
default['elastalert']['elasticsearch']['buffer_time']['value'] = 15
default['elastalert']['elasticsearch']['alert_time_limit']['unit'] = 'days'
default['elastalert']['elasticsearch']['alert_time_limit']['value'] = 2
default['elastalert']['log_dir'] = '/var/log/elastalert'

default['elastalert']['user'] = 'elastalert'
default['elastalert']['user_home'] = "/home/#{node['elastalert']['user']}"
default['elastalert']['group'] = 'elastalert'
default['elastalert']['directory'] = '/opt/elastalert'
default['elastalert']['rules_directory'] = "#{node['elastalert']['directory']}/rules"
default['elastalert']['virtualenv']['directory'] = "#{node['elastalert']['directory']}/.env"

default['elastalert']['supervisor']['logfile'] = "#{node['elastalert']['log_dir']}/elastalert_supervisord.log"
default['elastalert']['supervisor']['logfile_maxbytes'] = '1MB'
default['elastalert']['supervisor']['logfile_backups'] = 2
default['elastalert']['supervisor']['err_logfile'] = "#{node['elastalert']['log_dir']}/elastalert_stderr.log"
default['elastalert']['supervisor']['err_logfile_maxbytes'] = '5MB'
default['elastalert']['supervisor']['run_command'] = "#{node['elastalert']['virtualenv']['directory']}/bin/elastalert --config #{node['elastalert']['directory']}/config.yml --verbose"
