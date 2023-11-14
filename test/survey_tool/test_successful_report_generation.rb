# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestGenerateReport < Minitest::Test
    attr_reader :output

    def setup
      @output = File.read("test/fixtures/output/valid_survey_output.txt")
    end

    class TestSpecifyingOnlyQuestionsFileShort < TestGenerateReport
      def setup
        ARGV.push("-q", "test/fixtures/valid_survey_questions.csv")
      end

      def test_assumes_responses_file_location_and_prints_a_report_to_stdout
        # Application will find the following file:
        # test/fixtures/responses/valid_survey_questions-responses.csv
        assert_output(output) do
          SurveyTool.start
        end
      end
    end

    class TestSpecifyingOnlyQuestionsFileLong < TestGenerateReport
      def setup
        ARGV.push(
          "--questions_filepath",
          "test/fixtures/valid_survey_questions.csv"
        )
      end

      def test_assumes_responses_file_location_and_prints_a_report_to_stdout
        # Application will find the following file:
        # test/fixtures/responses/valid_survey_questions-responses.csv
        assert_output(output) do
          SurveyTool.start
        end
      end
    end

    class TestSpecifyingQuestionAndResponseFilesShort < TestGenerateReport
      def setup
        ARGV.push(
          "-q",
          "test/fixtures/valid_survey_questions.csv",
          "-r",
          "test/fixtures/valid_survey_responses.csv"
        )
      end

      def test_prints_a_report_to_stdout
        assert_output(output) do
          SurveyTool.start
        end
      end
    end

    class TestSpecifyingQuestionAndResponseFilesLong < TestGenerateReport
      def setup
        ARGV.push(
          "--questions_filepath",
          "test/fixtures/valid_survey_questions.csv",
          "--responses_filepath",
          "test/fixtures/valid_survey_responses.csv"
        )
      end

      def test_prints_a_report_to_stdout
        assert_output(output) do
          SurveyTool.start
        end
      end
    end
  end
end
