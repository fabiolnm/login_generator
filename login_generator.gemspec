# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'login_generator/version'

Gem::Specification.new do |gem|
  gem.name          = "login_generator"
  gem.version       = LoginGenerator::VERSION
  gem.authors       = ["Fábio Luiz Nery de Miranda"]
  gem.email         = ["fabio@miranti.net.br"]
  gem.description   = %q{Utility gem to generate logins from emails}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/fabiolnm/login_generator"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
