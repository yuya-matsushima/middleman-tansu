# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-tansu/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-tansu"
  spec.version       = Middleman::Tansu::VERSION
  spec.authors       = ["Yuya Terajima"]
  spec.email         = ["terra@e2esound.com"]
  spec.summary       = %q{A Template of Middleman.}
  spec.description   = %q{A Template of Middleman.}
  spec.homepage      = "https://github.com/yterajima/middleman-tansu"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency "middleman", "~> 3.3"
  spec.add_runtime_dependency "middleman-syntax", "~> 2.0"
  spec.add_runtime_dependency "middleman-gemoji", ">= 0.0.2"
  spec.add_runtime_dependency "slim", "~> 3.0"
  spec.add_runtime_dependency "redcarpet", "~> 3.2"
  spec.add_runtime_dependency "builder", "~> 3.2"

  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "aruba", "~> 0.6"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10"
end
