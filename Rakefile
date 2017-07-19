# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

task :tests, [:coverage] do |_task, args|
  if args.coverage == "NO_COVERAGE"
    ENV["NO_COVERAGE"] = "true"
  end
  Rake::Task[:test].invoke
end

task default: :tests
