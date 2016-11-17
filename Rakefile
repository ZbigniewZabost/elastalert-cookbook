require 'cookstyle'
require 'rubocop/rake_task'
require 'rake-foodcritic'

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end

task style: [:rubocop, :'chef:foodcritic']
