# frozen_string_literal: true

require_relative "lib/ombu_labs/shortener/version"

Gem::Specification.new do |spec|
  spec.name = "ombu_labs-shortener"
  spec.version = OmbuLabs::Shortener::VERSION
  spec.authors = ["Ernesto Tagwerker"]
  spec.email = ["ernesto+github@ombulabs.com"]

  spec.summary = "One executable to shorten all the long URLs related to OmbuLabs."
  spec.description = "Knows how to shorten links associated with OmbuLabs and FastRuby.io."
  spec.homepage = "https://github.com/fastruby/ombu_labs-shortener"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fastruby/ombu_labs-shortener"
  spec.metadata["changelog_uri"] = "https://github.com/fastruby/ombu_labs-shortener/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rebrandly"
  spec.add_development_dependency "byebug"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
