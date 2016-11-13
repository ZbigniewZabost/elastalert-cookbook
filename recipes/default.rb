include_recipe 'git'

elastalert_group = 'elastalert'
elastalert_user = 'elastalert'
elastalert_dir = '/opt/elastalert'
elastalert_venv = "#{elastalert_dir}/.env"
elastalert_version = 'v0.1.3'
elastalert_repo = 'https://github.com/Yelp/elastalert.git'


group elastalert_group

user elastalert_user do
  group elastalert_group
  home "/home/#{elastalert_user}"
  manage_home true
end

directory elastalert_dir do
  owner elastalert_user
  group elastalert_group
  mode '0755'
end

git 'elastalert' do
  repository elastalert_repo
  revision elastalert_version
  destination elastalert_dir
  user elastalert_user
  group elastalert_group
  action :checkout
end

python_runtime '2' do
  options dev_package: 'build-essential python-dev'
end

python_virtualenv elastalert_venv do
  group elastalert_group
  user elastalert_user
end

python_execute "#{elastalert_dir}/setup.py install" do
  user elastalert_user
  group elastalert_group
  virtualenv elastalert_venv
  cwd elastalert_dir
end

pip_requirements "#{elastalert_dir}/requirements.txt" do
  user elastalert_user
  group elastalert_group
  virtualenv elastalert_venv
  options '-v'
  cwd elastalert_dir
  retries 1
end

python_execute 'setup elastalert index' do
  command "#{elastalert_venv}/local/bin/elastalert-create-index --host localhost --port 9200 --no-auth --no-ssl --index elastalert_status --url-prefix '' --old-index '' "
  user elastalert_user
  group elastalert_group
  virtualenv elastalert_venv
  cwd elastalert_dir
end

# create rules directory
# copy rules to direcotry

# run elastalert
# python -m elastalert.elastalert --verbose --rule example_frequency.yaml  # or use the entry point: elastalert --verbose --rule ...
