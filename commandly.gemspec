# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "commandly/version"

Gem::Specification.new do |spec|
  spec.name          = "commandly"
  spec.version       = Commandly::VERSION
  spec.authors       = ["Louie Bao"]
  spec.email         = ["louie.bao@vuebly.com"]
  spec.summary       = "A ruby gem for creating iOS & Android project from template"
  spec.homepage      = "https://github.com/louie007/commandly"
  spec.license       = "MIT"
  spec.description   = <<-EOM
                        Commandly is a command line tool for creating iOS and/or Android project.
                        It lets you create projects from a local or remote template, it's simple to use and easy to customize.
                        EOM
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'thor'
end
