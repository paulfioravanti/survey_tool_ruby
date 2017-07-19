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
    attr_reader :help_output

    def setup
      @help_output = File.read("test/fixtures/output/help_output.txt")
    end

    class TestNoOptions < TestOptionErrors
      attr_reader :error_output_mock

      def setup
        # ARGV remains []
        @error_output_mock =
          Minitest::Mock.new.expect(
            :call,
            :error_retval,
            ["missing argument: questions_filepath"]
          )
      end

      def test_application_prints_error_message_with_help
        CLI::Output.stub(:error, error_output_mock) do
          assert_output(help_output) do
            assert_raises(SystemExit) { Application.start }
          end
        end
      end
    end

    class TestQuestionOptionButNoFile < TestOptionErrors
      attr_reader :error_output_mock

      def setup
        ARGV.push("--questions_filepath")
        @error_output_mock =
          Minitest::Mock.new.expect(
            :call,
            :error_retval,
            ["missing argument: --questions_filepath"]
          )
      end

      def test_application_prints_error_message_with_help
        CLI::Output.stub(:error, error_output_mock) do
          assert_output(help_output) do
            assert_raises(SystemExit) { Application.start }
          end
        end
      end
    end

    class TestResponseOptionButNoFile < TestOptionErrors
      attr_reader :error_output_mock

      # rubocop:disable Metrics/MethodLength
      def setup
        ARGV.push(
          "--questions_filepath",
          "test/fixtures/questions/valid_survey_questions.csv",
          "--responses_filepath"
        )
        @error_output_mock =
          Minitest::Mock.new.expect(
            :call,
            :error_retval,
            ["missing argument: --responses_filepath"]
          )
      end
      # rubocop:enable Metrics/MethodLength

      def test_application_prints_error_message_with_help
        CLI::Output.stub(:error, error_output_mock) do
          assert_output(help_output) do
            assert_raises(SystemExit) { Application.start }
          end
        end
      end
    end

    class TestOnlyResponseOption < TestOptionErrors
      attr_reader :error_output_mock

      def setup
        ARGV.push(
          "--responses_filepath",
          "test/fixtures/responses/valid_survey_responses.csv"
        )
        @error_output_mock =
          Minitest::Mock.new.expect(
            :call,
            :error_retval,
            ["missing argument: questions_filepath"]
          )
      end

      def test_application_prints_error_message_with_help
        CLI::Output.stub(:error, error_output_mock) do
          assert_output(help_output) do
            assert_raises(SystemExit) { Application.start }
          end
        end
      end
    end
  end
end
