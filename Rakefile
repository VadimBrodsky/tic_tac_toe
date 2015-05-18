require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |task|
  task.pattern = 'test/*_test.rb'
end

desc 'Run rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end

task default: :test
