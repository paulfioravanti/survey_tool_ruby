# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestNonExistentQuestionsFile < Minitest::Test
    attr_reader :output

    # rubocop:disable Metrics/MethodLength
    def setup
      questions_filepath =
        "test/fixtures/questions/non_existent_survey_questions.csv"
      ARGV.push("--questions_filepath", questions_filepath)
      @output =
        CLI::Output.__send__(
          :error,
          "Could not generate report: "\
          "No such file or directory @ rb_sysopen - "\
          "#{File.expand_path(questions_filepath)} "\
          "(Errno::ENOENT)"
        ) + "\n"
    end
    # rubocop:enable Metrics/MethodLength

    def test_application_prints_the_error_to_stdout
      assert_output(output) do
        assert_raises(SystemExit) { Application.start }
      end
    end
  end

  class TestQuestionsFileWithMissingHeaders < Minitest::Test
    attr_reader :output

    # rubocop:disable Metrics/MethodLength
    def setup
      questions_filepath = "test/fixtures/questions/missing_headers.csv"
      ARGV.push(
        "--questions_filepath",
        questions_filepath,
        "--responses_filepath",
        "test/fixtures/responses/valid_survey_responses.csv"
      )
      @output =
        CLI::Output.__send__(
          :error,
          "Could not generate report: "\
          "CSV file "\
          "#{File.expand_path(questions_filepath)} "\
          "is missing headers. "\
          "(SurveyTool::MissingHeadersError)"
        ) + "\n"
    end
    # rubocop:enable Metrics/MethodLength

    def test_application_prints_the_error_to_stdout
      assert_output(output) do
        assert_raises(SystemExit) { Application.start }
      end
    end
  end

  class TestQuestionsFileWithUnknownQuestionTypes < Minitest::Test
    attr_reader :output

    # rubocop:disable Metrics/MethodLength
    def setup
      questions_filepath = "test/fixtures/questions/unknown_question_types.csv"
      ARGV.push(
        "--questions_filepath",
        questions_filepath,
        "--responses_filepath",
        "test/fixtures/responses/valid_survey_responses.csv"
      )
      @output =
        CLI::Output.__send__(
          :error,
          "Could not generate report: "\
          "CSV file "\
          "#{File.expand_path(questions_filepath)} "\
          "has unknown question type 'unknown' "\
          "(SurveyTool::UnknownQuestionTypeError)"
        ) + "\n"
    end
    # rubocop:enable Metrics/MethodLength

    def test_application_prints_the_error_to_stdout
      assert_output(output) do
        assert_raises(SystemExit) do
          Application.start
        end
      end
    end
  end
end
