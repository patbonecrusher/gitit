require "bundler/gem_tasks"
require "rake/testtask"
require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new do |task|
  task.pattern = Dir['spec/**/*_spec.rb'].sort
  task.rspec_opts = Dir.glob("[0-9][0-9][0-9]_*").collect { |x| "-I#{x}" }
  task.rspec_opts << '--color -f d'
end

task :default => :spec

task :coverage do
  # add simplecov
  ENV["COVERAGE"] = 'yes'

  # run the specs
  Rake::Task['spec'].execute
end


