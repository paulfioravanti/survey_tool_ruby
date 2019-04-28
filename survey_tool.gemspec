# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "survey_tool/version"

Gem::Specification.new do |spec|
  spec.name = "survey_tool"
  spec.version = SurveyTool::VERSION
  spec.authors = ["Paul Fioravanti"]
  spec.email = ["paul.fioravanti@gmail.com"]
  spec.summary = "Survey Data CLI Application"
  spec.description = <<~DESC
    A CLI application that parses and displays survey data from CSV files,
    and display the results.
  DESC
  spec.license = "MIT"
  spec.files =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  spec.executables   = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "terminal-table", "~> 1.8"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "bundler-audit", "~> 0.6"
  # NOTE: guard-minitest does not have Guard as a dependency,
  # hence explicitly adding it in.
  spec.add_development_dependency "guard", "~> 2.15"
  spec.add_development_dependency "guard-minitest", "~> 2.4"
  spec.add_development_dependency "guard-reek", "~> 1.0"
  spec.add_development_dependency "guard-rubocop", "~> 1.2"
  spec.add_development_dependency "guard-yard", "~> 2.2"
  spec.add_development_dependency "kramdown", "~> 2.1"
  spec.add_development_dependency "license_finder", "~> 5.7"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-focus", "~> 1.1"
  spec.add_development_dependency "minitest-reporters", "~> 1.3"
  spec.add_development_dependency "pry-byebug", "~> 3.7"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "redcarpet", "~> 3.4"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2"
  spec.add_development_dependency "simplecov", "~> 0.14"
end
