# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'light_services/version'

Gem::Specification.new do |spec|
  spec.name          = "light_services"
  spec.version       = LightServices::VERSION
  spec.authors       = ["Nicolas Lima"]
  spec.email         = ["lima.nicolasmateus@gmail.com"]

  spec.summary       = %q{A simple base to help build Services}
  spec.description   = %q{A simple base to help build Services}
  spec.homepage      = "https://github.com/nicolaslima/light_services"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "activemodel", ">= 4.2.6"
end
