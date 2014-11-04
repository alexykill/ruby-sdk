# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xapo_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "xapo_sdk"
  spec.version       = XapoSdk::VERSION
  spec.authors       = ["Federico Repond"]
  spec.email         = ["federico.repond@leapsight.com"]
  spec.summary       = %q{Xapo bitcoin sdk & tools.}
  spec.description   = %q{Xapo bitcoin sdk & tools.}
  spec.homepage      = ""
  spec.license       = "BSD"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.4.2"
end
