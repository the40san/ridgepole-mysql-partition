# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ridgepole/mysql/partition/version"

Gem::Specification.new do |spec|
  spec.name          = "ridgepole-mysql-partition"
  spec.version       = Ridgepole::MySQL::Partition::VERSION
  spec.authors       = ["Masashi AKISUE"]
  spec.email         = ["m.akisue.b@gmail.com"]

  spec.summary       = %q{The plugin to define MySQL range partition for ridgepole}
  spec.description   = %q{The plugin to define MySQL range partition for ridgepole}
  spec.homepage      = "https://github.com/the40san/ridgepole-mysql-partition"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
