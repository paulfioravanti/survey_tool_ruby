# frozen_string_literal: true

require "test_helper"

module SurveyTool
  class TestHelp < Minitest::Test
    attr_reader :output

    def setup
      @output = File.read("test/fixtures/output/help_output.txt")
    end

    class TestShortOption < TestHelp
      def setup
        ARGV.push("-h")
      end

      def test_help_prints_out_the_help_message
        assert_output(output) do
          assert_raises(SystemExit) do
            Application.start
          end
        end
      end
    end

    class TestLongOption < TestHelp
      def setup
        ARGV.push("--help")
      end

      def test_help_prints_out_the_help_message
        assert_output(output) do
          assert_raises(SystemExit) do
            Application.start
          end
        end
      end
    end
  end
end
