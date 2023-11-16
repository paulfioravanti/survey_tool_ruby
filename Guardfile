# frozen_string_literal: true

group :red_green_refactor, halt_on_fail: true do
  # NOTE: Coverage doesn't seem to be accurate when run with Guard, even if the
  # whole suite runs. So, if you want to refresh the coverage reports, run the
  # test suite from the command-line manually.
  guard :minitest, env: { "NO_COVERAGE" => true }, all_on_start: false do
    watch(%r{\Atest/(.*)/?test_(.*)\.rb\z})
    # NOTE: Since there are no unit test files, there is no one-to-one
    # relationship between lib files and test files. So, when a change occurs
    # in the code, just run the entire suite.
    watch(%r{\Alib/(.*/)?([^/]+)\.rb\z}) { "test" }
    watch(%r{\Atest/test_helper\.rb\z}) { "test" }
  end

  # NOTE: Unavoidable warning present about binstubs. Okay to ignore
  guard :reek, all_on_start: false do
    watch(/.+\.rb$/)
    watch(".reek")
  end

  guard :rubocop,
        all_on_start: false,
        cli: ["--display-cop-names"],
        cmd: "./bin/rubocop" do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
  end

  # NOTE: Unavoidable warning present about binstubs. Okay to ignore.
  guard :yard, cli: "--reload" do
    watch(%r{app/.+\.rb})
    watch(%r{lib/.+\.rb})
    watch(%r{ext/.+\.c})
  end
end
