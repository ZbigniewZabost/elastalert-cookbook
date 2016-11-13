elast_ver = node['elastalert']['version']
elast_repo = node['elastalert']['repository']
elast_es_host = node['elastalert']['elasticsearch']['hostname']
elast_es_port = node['elastalert']['elasticsearch']['port']
elast_es_index = node['elastalert']['elasticsearch']['index']
elast_es_old_index = node['elastalert']['elasticsearch']['index_old']
elast_es_url_prefix = node['elastalert']['elasticsearch']['url_prefix']
elast_es_index_create_opts = node['elastalert']['elasticsearch']['create_index_opts']
elast_group = node['elastalert']['group']
elast_user = node['elastalert']['user']
elast_user_home = node['elastalert']['user_home']
elast_dir = node['elastalert']['directory']
elast_venv = node['elastalert']['virtualenv']['directory']

include_recipe 'git'

group elast_group

user elast_user do
  group elast_group
  home elast_user_home
  manage_home true
end

directory elast_dir do
  owner elast_user
  group elast_group
  mode '0755'
end

git 'elastalert' do
  repository elast_repo
  revision elast_ver
  destination elast_dir
  user elast_user
  group elast_group
  action :checkout
end

python_runtime '2' do
  options dev_package: 'build-essential python-dev'
end

python_virtualenv elast_venv do
  group elast_group
  user elast_user
  not_if do ::File.exist?(elast_venv) end
end

python_execute "#{elast_dir}/setup.py install" do
  user elast_user
  group elast_group
  virtualenv elast_venv
  cwd elast_dir
  not_if do ::File.exist?("#{elast_venv}/local/bin/elastalert-create-index") end
  notifies :install, "pip_requirements[#{elast_dir}/requirements.txt]", :immediately
end

pip_requirements "#{elast_dir}/requirements.txt" do
  user elast_user
  group elast_group
  virtualenv elast_venv
  options '-v'
  cwd elast_dir
  retries 1   # 1st try fails on clean up step when trying to remove not existing file, 2nd try is successful
  action :nothing
end

python_execute 'setup elastalert index' do
  command "#{elast_venv}/local/bin/elastalert-create-index --host #{elast_es_host} --port #{elast_es_port} --index '#{elast_es_index}' --url-prefix '#{elast_es_url_prefix}' --old-index '#{elast_es_old_index}' #{elast_es_index_create_opts}"
  user elast_user
  group elast_group
  virtualenv elast_venv
  cwd elast_dir
  not_if "curl -XGET 'http://#{elast_es_host}:#{elast_es_port}/#{elast_es_index}/' -s | grep '@timestamp'"
end

directory "#{elast_dir}/rules" do
  user elast_user
  group elast_group
  mode '0755'
end

managed_directory "#{elast_dir}/rules" do
  clean_directories true
end

# TODO:
# add supervisord
# add supervisord config template
# add elastalert config tempalte
# run elastalert
