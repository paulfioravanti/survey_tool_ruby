# frozen_string_literal: true

require "test_helper"

module SurveyTool
  # NOTE: Error outputting happens in two stages:
  #
  # 1. The error message (in red)
  # 2. The help message
  #
  # It only seems possible to assert against the "final" output when the
  # following types of errors occur i.e. the "help" output.  Asserting
  # that an error was output with the expected string message is left
  # up to mocks.
  class TestOptionErrors < Minitest::Test
    attr_reader :help_output, :error_output

    def setup
      @help_output = File.read("test/fixtures/output/help_output.txt")
    end

    class TestNoOptions < TestOptionErrors
      def setup
        # ARGV remains []
        super
        @error_output =
          CLI::Output.__send__(:error, "missing argument: questions_filepath")
      end

      def test_application_prints_error_message_with_help
        assert_output("#{error_output}\n#{help_output}") do
          Application.start
        end
      end
    end

    class TestQuestionOptionButNoFile < TestOptionErrors
      def setup
        super
        ARGV.push("--questions_filepath")
        @error_output =
          CLI::Output.__send__(:error, "missing argument: --questions_filepath")
      end

      def test_application_prints_error_message_with_help
        assert_output("#{error_output}\n#{help_output}") do
          Application.start
        end
      end
    end

    class TestResponseOptionButNoFile < TestOptionErrors
      def setup
        super
        ARGV.push(
          "--questions_filepath",
          "test/fixtures/questions/valid_survey_questions.csv",
          "--responses_filepath"
        )
        @error_output =
          CLI::Output.__send__(:error, "missing argument: --responses_filepath")
      end

      def test_application_prints_error_message_with_help
        assert_output("#{error_output}\n#{help_output}") do
          Application.start
        end
      end
    end

    class TestOnlyResponseOption < TestOptionErrors
      def setup
        super
        ARGV.push(
          "--responses_filepath",
          "test/fixtures/responses/valid_survey_responses.csv"
        )
        @error_output =
          CLI::Output.__send__(:error, "missing argument: questions_filepath")
      end

      def test_application_prints_error_message_with_help
        assert_output("#{error_output}\n#{help_output}") do
          Application.start
        end
      end
    end
  end
end
