# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestNoSubmittedResponses < Minitest::Test
    attr_reader :output

    def setup
      ARGV.push(
        "--questions_filepath",
        "test/fixtures/questions/no_submitted_questions.csv",
        "--responses_filepath",
        "test/fixtures/responses/no_submitted_responses.csv"
      )
      @output =
        File.read("test/fixtures/output/no_submitted_responses_output.txt")
    end

    def test_prints_a_blank_report_to_stdout
      assert_output(output) do
        Application.start
      end
    end
  end
end
