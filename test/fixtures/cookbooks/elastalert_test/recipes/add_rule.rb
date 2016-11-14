cookbook_file '/opt/elastalert/rules/test_rule.yml' do
  source 'rules/test_rule.yml'
  owner 'elastalert'
  group 'elastalert'
  mode '0755'
  action :create
end
