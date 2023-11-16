# frozen_string_literal: true

group :red_green_refactor, halt_on_fail: true do
  guard :minitest,
        env: { "NO_COVERAGE" => "true" },
        all_on_start: false do
    watch(%r{\Atest/(.*)/?test_(.*)\.rb\z})
    # Since there are no unit test files, there is no one-to-one relationship
    # between lib files and test files. So, when a change occurs in the code,
    # just run the entire suite.
    watch(%r{\Alib/(.*/)?([^/]+)\.rb\z}) { "test" }
    watch(%r{\Atest/test_helper\.rb\z}) { "test" }
  end

  guard :reek, all_on_start: false do
    watch(/.+\.rb$/)
    watch(".reek")
  end

  guard :rubocop, all_on_start: false, cli: ["--display-cop-names"] do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :yard, cli: "--reload" do
    watch(%r{app/.+\.rb})
    watch(%r{lib/.+\.rb})
    watch(%r{ext/.+\.c})
  end
end
