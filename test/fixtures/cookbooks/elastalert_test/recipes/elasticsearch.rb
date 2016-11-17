include_recipe 'java'

elasticsearch_user 'elasticsearch'

elasticsearch_install 'elasticsearch' do
  type :package
end

elasticsearch_configure 'elasticsearch' do
  allocated_memory '256m'
  configuration(
    'cluster.name' => 'mycluster',
    'node.name' => 'node01'
  )
end

elasticsearch_service 'elasticsearch' do
  service_actions [:enable, :start]
end
