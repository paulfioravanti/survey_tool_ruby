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
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = "3.2.2"

  spec.add_runtime_dependency "terminal-table", "~> 3.0"
end
