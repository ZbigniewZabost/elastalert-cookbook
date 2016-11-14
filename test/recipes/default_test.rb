# # encoding: utf-8

describe user('elastalert') do
  it { should exist }
  its('group') { should eq 'elastalert' }
  its('home') { should eq '/home/elastalert' }
end

describe directory('/opt/elastalert/.env') do
  it { should exist}
  its('owner') { should eq 'elastalert' }
  its('group') { should eq 'elastalert' }
  its('mode') { should cmp '0755' }
end

describe bash('/opt/elastalert/.env/bin/python --version') do
  its('stderr') { should match /Python 2\.[0-9]+\.[0-9]+/ } # https://bugs.python.org/issue18338
end

['elastalert', 'elastalert-create-index', 'elastalert-rule-from-kibana', 'elastalert-test-rule'].each do |command|
  describe file("/opt/elastalert/.env/local/bin/#{command}") do
      it { should exist }
      its('owner') { should eq 'elastalert' }
      its('group') { should eq 'elastalert' }
  end
end

describe command('curl -XGET http://localhost:9200/elastalert_status -s') do
  its('stdout') { should include '@timestamp'}
end

describe directory('/opt/elastalert/rules') do
  it { should exist}
  its('owner') { should eq 'elastalert' }
  its('group') { should eq 'elastalert' }
  its('mode') { should cmp '0755' }
end

describe file('/opt/elastalert/rules/test_rule.yml') do
  it { should exist}
  its('owner') { should eq 'elastalert' }
  its('group') { should eq 'elastalert' }
  its('mode') { should cmp '0755' }
end
