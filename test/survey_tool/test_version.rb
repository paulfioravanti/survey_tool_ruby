# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestVersion < Minitest::Test
    attr_reader :output

    def setup
      @output = "#{VERSION}\n"
    end

    class TestShortOption < TestVersion
      def setup
        ARGV.push("-v")
      end

      def test_prints_out_the_survey_tool_version
        assert_output(output) do
          Application.start
        end
      end
    end

    class TestLongOption < TestVersion
      def setup
        ARGV.push("--version")
      end

      def test_prints_out_the_survey_tool_version
        assert_output(output) do
          Application.start
        end
      end
    end
  end
end
