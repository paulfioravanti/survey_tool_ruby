# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestApplicationHelpShortOption < Minitest::Test
    attr_reader :output

    def setup
      ARGV.push("-h")
      @output = File.read("test/fixtures/help_output.txt")
    end

    def test_help_prints_out_the_help_message
      assert_output(output) do
        assert_raises(SystemExit) { Application.start }
      end
    end
  end

  class TestApplicationHelpLongOption < Minitest::Test
    attr_reader :output

    def setup
      ARGV.push("--help")
      @output = File.read("test/fixtures/help_output.txt")
    end

    def test_help_prints_out_the_help_message
      assert_output(output) do
        assert_raises(SystemExit) { Application.start }
      end
    end
  end
end
