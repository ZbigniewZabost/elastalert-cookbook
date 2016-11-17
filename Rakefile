require 'cookstyle'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end

task :foodcritic do
  if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)
    sh 'bundle exec foodcritic . --epic-fail correctness -X test/'
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
  end
end

task style: [:rubocop, :foodcritic]

RSpec::Core::RakeTask.new(:unit)

Kitchen::RakeTasks.new
