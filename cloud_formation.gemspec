# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloud_formation/version'

Gem::Specification.new do |spec|
  spec.name          = "cloud_formation"
  spec.version       = CloudFormation::VERSION
  spec.authors       = ["David White"]
  spec.email         = ["david.white@spry-soft.com"]
  spec.summary       = %q{A Ruby gem to create AWS CloudFormation descriptions.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/davidrhyswhite/cloud_formation"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"
end
