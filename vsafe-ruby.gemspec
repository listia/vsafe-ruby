# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "vsafe/version"

Gem::Specification.new do |spec|
  spec.name          = "vsafe-ruby"
  spec.version       = VSafe::VERSION
  spec.authors       = ["Ngan Pham", "Xenor Chang"]
  spec.email         = ["ngan@listia.com", "xenor@listia.com"]

  spec.summary       = %q{Ruby API Library for Vesta's vSafe Payment Gateway.}
  spec.description   = %q{Ruby API Library for Vesta's vSafe Payment Gateway.}
  spec.homepage      = "https://github.com/listia/vsafe-ruby"

  spec.files         = Dir["{lib,spec}/**/*"].select { |f| File.file?(f) } +
                             %w(Rakefile README.md)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.13"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "webmock", "~> 1.24"
  spec.add_development_dependency "byebug"
end
