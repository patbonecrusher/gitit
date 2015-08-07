# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end
require 'rake'

#require 'jeweler'
#Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
#  gem.name = "gitit"
#  gem.homepage = "http://github.com/patbonecrusher/gitit"
#  gem.license = "MIT"
#  gem.summary = %Q{Ruby git wrapper for the command line thin}
#  gem.description = %Q{longer description of your gem}
#  gem.email = "pat@covenofchaos.com"
#  gem.authors = ["Bone Crusher"]
  # dependencies defined in Gemfile
#end
#Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
  spec.rspec_opts = Dir.glob('[0-9][0-9][0-9]_*').collect { |x| "-I#{x}" }
  spec.rspec_opts << '--color -f d'
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

RSpec::Core::RakeTask.new(:coverage) do |spec|
  # add simplecov
  ENV['COVERAGE'] = 'yes'

  # run the specs
  Rake::Task['spec'].execute
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "gitit #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir.glob('lib/tasks/*.rake').each {|r| import r}
