# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docker/env/version'

Gem::Specification.new do |spec|
  spec.name          = "docker-env"
  spec.version       = Docker::Env::VERSION
  spec.authors       = ["Jakub Głuszecki"]
  spec.email         = ["jakub.gluszecki@gmail.com"]
  spec.summary       = %q{Utility for running dockerized apps outside of docker container}
  spec.homepage      = "https://github.com/cthulhu666/docker-env"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "docker-api"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

