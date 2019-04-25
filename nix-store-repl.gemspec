
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nix/store/repl/version"

Gem::Specification.new do |spec|
  spec.name          = "nix-store-repl"
  spec.version       = Nix::Store::REPL::VERSION
  spec.authors       = ["Burke Libbey"]
  spec.email         = ["burke@libbey.me"]

  spec.summary       = %q{REPL for nix store}
  spec.description   = %q{REPL for nix store}
  spec.homepage      = "https://github.com/Shopify/nix-store-repl"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "pry", "~> 0.12"
end
