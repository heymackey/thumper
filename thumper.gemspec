# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thumper/version'

Gem::Specification.new do |spec|
  spec.name          = "thumper"
  spec.version       = Thumper::VERSION
  spec.authors       = ["Daniel Mackey"]
  spec.email         = ["thumper@danielmackey"]
  spec.summary       = %q{Command line tool for inspecting RabbitMQ messages as they happen}
  spec.description   = %q{Command line tool for inspecting RabbitMQ messages as they happen}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   << 'thumper'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
