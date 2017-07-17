require "optparse"
require_relative "../colours"
require_relative "../version"

module SurveyTool
  module CLI
    module ArgumentParser
      REQUIRED_OPTIONS = [:questions_filepath].freeze
      private_constant :REQUIRED_OPTIONS

      module_function

      def fetch_filepaths
        options = {}
        optparse = option_parser(options)
        optparse.parse!(ARGV)
        check_missing_options(optparse, options)
        [options[:questions_filepath], responses_filepath(options)]
      rescue OptionParser::InvalidOption, OptionParser::MissingArgument => error
        puts Colours.red(error.to_s)
        puts optparse
        exit(1)
      end

      # NOTE: OptionParser API forcing the long method, so ignore Rubocop
      # rubocop:disable Metrics/MethodLength
      def option_parser(options)
        OptionParser.new do |parser|
          parser.banner = "Usage: ./bin/survey-tool [options]"
          parser.separator("")
          parser.separator "Specific options:"
          questions_filepath_option(parser, options)
          responses_filepath_option(parser, options)
          parser.separator("")
          parser.separator "Common options:"
          help_option(parser)
          version_option(parser)
        end
      end
      # rubocop:enable Metrics/MethodLength
      private_class_method :option_parser

      def questions_filepath_option(parser, options)
        parser.on(
          "-q",
          "--questions_filepath FILEPATH",
          "The FILEPATH of the questions file."
        ) do |filepath|
          options[:questions_filepath] = filepath
        end
      end
      private_class_method :questions_filepath_option

      def responses_filepath_option(parser, options)
        parser.on(
          "-r",
          "--responses_filepath FILEPATH",
          "The FILEPATH of the responses file. "\
          "Defaults to the <questions_filepath>-responses.csv"
        ) do |filepath|
          options[:responses_filepath] = filepath
        end
      end
      private_class_method :responses_filepath_option

      def help_option(parser)
        parser.on_tail("-h", "--help", "Show this message") do
          puts parser
          exit(0)
        end
      end
      private_class_method :help_option

      def version_option(parser)
        parser.on_tail("-v", "--version", "Show version") do
          puts SurveyTool::VERSION
          exit(0)
        end
      end
      private_class_method :version_option

      def check_missing_options(optparse, options)
        missing = REQUIRED_OPTIONS.select { |option| options[option].nil? }
        if missing.any?
          raise OptionParser::MissingArgument, missing.join(", ")
        end
      end
      private_class_method :check_missing_options

      # Returns either the responses filepath given from the command line, or
      # determine a default filepath based on the following formula:
      # example-data/survey-1.csv
      # becomes
      # example-data/survey-1-responses.csv
      def responses_filepath(options)
        options[:responses_filepath] ||
          options[:questions_filepath].
            split(/(?=[.].+\z)/).
            insert(1, "-responses").
            join
      end
      private_class_method :responses_filepath
    end
  end
end
