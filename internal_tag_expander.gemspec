
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "internal_tag_expander/version"

Gem::Specification.new do |spec|
  spec.name          = "internal_tag_expander"
  spec.version       = InternalTagExpander::VERSION
  spec.authors       = ["Ken Barker"]
  spec.email         = ["ken.barker@gmail.com"]

  spec.summary       = %q{Expands Gollum include tags.}
  spec.description   = %q{Expands [[include:other-wiki-page]] tags recursively outside of wiki rendering (for PDF creation via pandoc).}
  spec.homepage      = "http://example.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://example.com"
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

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "5.10.3"
  spec.add_development_dependency "purdytest"
end
