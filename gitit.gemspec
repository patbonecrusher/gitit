# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitit/version'

Gem::Specification.new do |gem|
  gem.name          = 'gitit'
  gem.version       = File.exist?('VERSION') ? File.read('VERSION') : Gitit::VERSION
  gem.authors       = ['Pat Laplante']
  gem.email         = ['pat@covenofchaos.com']
  gem.description   = %q{"ruby git command line wrapper"}
  gem.summary       = 'Git command line wrapper.  Allow operations on git repos'
  gem.homepage      = 'http://github.com/patbonecrusher/gitit'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  gem.licenses      = ['MIT']


  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake', '= 10.3.1'
  gem.add_development_dependency 'rspec', '= 3.3.0'
  gem.add_development_dependency 'guard-rspec', '= 4.2.8'
  gem.add_development_dependency 'cli-colorize', '= 2.0.0'
  gem.add_development_dependency 'simplecov', '= 0.8.2'

end
