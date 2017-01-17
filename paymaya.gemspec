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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rest-client", "~> 2.0"
  spec.add_development_dependency "plissken", "~> 0.2"
  spec.add_development_dependency "awrence", "~> 0.1"
end
