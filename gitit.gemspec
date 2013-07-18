# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitit/version'

Gem::Specification.new do |gem|
  gem.name          = "gitit"
  gem.version       = Gitit::VERSION
  gem.authors       = ["Pat Laplante"]
  gem.email         = ["pat@covenofchaos.com"]
  gem.description   = %q{"ruby git command line wrapper"}
  gem.summary       = ""
  gem.homepage      = "http://github.com/patbonecrusher/gitit"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
