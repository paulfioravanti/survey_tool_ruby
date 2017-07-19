# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestApplicationVersionShortOption < Minitest::Test
    attr_reader :output

    def setup
      ARGV.push("-v")
      @output = "#{VERSION}\n"
    end

    def test_help_prints_out_the_survey_tool_version
      assert_output(output) do
        assert_raises(SystemExit) { Application.start }
      end
    end
  end

  class TestApplicationVersionLongOption < Minitest::Test
    attr_reader :output

    def setup
      ARGV.push("--version")
      @output = "#{VERSION}\n"
    end

    def test_help_prints_out_the_survey_tool_version
      assert_output(output) do
        assert_raises(SystemExit) { Application.start }
      end
    end
  end
end
