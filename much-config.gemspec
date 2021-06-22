# -*- encoding: utf-8 -*-
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "much-config/version"

Gem::Specification.new do |gem|
  gem.name        = "much-config"
  gem.version     = MuchConfig::VERSION
  gem.authors     = ["TODO: authors"]
  gem.email       = ["TODO: emails"]
  gem.summary     = "TODO: Write a gem summary"
  gem.description = "TODO: Write a gem description"
  gem.homepage    = "TODO: homepage"
  gem.license     = "MIT"

  gem.files = `git ls-files | grep "^[^.]"`.split($INPUT_RECORD_SEPARATOR)

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = "~> 2.5"

  gem.add_development_dependency("much-style-guide", ["~> 0.6.4"])
  gem.add_development_dependency("assert",           ["~> 2.19.6"])

  # TODO: gem.add_dependency("gem-name", ["~> 0.0.0"])
end
