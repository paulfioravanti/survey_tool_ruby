# frozen_string_literal: true
group :red_green_refactor, halt_on_fail: true do
  guard :minitest, all_on_start: false do
    # with Minitest::Unit
    watch(%r{^test/(.*)\/?test_(.*)\.rb$})
    watch(%r{^lib/(.*/)?([^/]+)\.rb$}) { |m| "test/#{m[1]}test_#{m[2]}.rb" }
    watch(%r{^test/test_helper\.rb$}) { 'test' }
  end

  guard :reek, all_on_start: false do
    watch(%r{.+\.rb$})
    watch('.reek')
  end

  guard :rubocop, all_on_start: false, cli: ["--display-cop-names"] do
    watch(%r{.+\.rb$})
    watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
  end

  guard :yard, cli: "--reload" do
    watch(%r{app\/.+\.rb})
    watch(%r{lib\/.+\.rb})
    watch(%r{ext\/.+\.c})
  end
end
