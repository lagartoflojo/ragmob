lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ragmob/version"

Gem::Specification.new do |spec|
  spec.name          = "ragmob"
  spec.version       = Ragmob::VERSION
  spec.authors       = ["Hernán Schmidt"]
  spec.email         = ["lagartoflojo@gmail.com"]

  spec.summary       = 'A library to interact with the BeyondTrust Remote Support API.'
  spec.homepage      = "https://github.com/lagartoflojo/ragmob"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "http", "~> 4.2"
  spec.add_dependency "nokogiri-happymapper", "~> 0.8"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "guard", "~> 2.16"
  spec.add_development_dependency "guard-minitest", "~> 2.4"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.4"
  spec.add_development_dependency "minitest-spec-context", "~> 0.0.4"
  spec.add_development_dependency "pry", "~> 0.12"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop", "~> 0.76"
  spec.add_development_dependency "rubocop-minitest", "~> 0.5"
  spec.add_development_dependency "vcr", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 3.7"
end
