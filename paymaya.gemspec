# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paymaya/version'

Gem::Specification.new do |spec|
  spec.name          = "paymaya"
  spec.version       = Paymaya::VERSION
  spec.authors       = ["PayMaya"]
  spec.email         = ["paymayadevs@voyager.ph"]

  spec.summary       = %q{PayMaya Ruby SDK}
  spec.description   = %q{Ruby SDK for easy integration with the PayMaya APIs.}
  spec.homepage      = "https://developers.paymaya.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "bundler", "~> 1.17"
  spec.add_runtime_dependency "rake", "~> 13.0"
  spec.add_runtime_dependency "rspec", "~> 3.10"
  spec.add_runtime_dependency "rest-client", "~> 2.0"
  spec.add_runtime_dependency "plissken", "~> 0.2"
  spec.add_runtime_dependency "awrence", "~> 0.1"
  spec.add_runtime_dependency "money", "~> 6.7"
end
