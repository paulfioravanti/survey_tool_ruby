require "optparse"
require_relative "output"
require_relative "../version"

module SurveyTool
  module CLI
    # CLI argument validity parser.
    #
    # @author Paul Fioravanti
    module ArgumentParser
      # Set of options that must be provided when running application.
      REQUIRED_OPTIONS = [:questions_filepath].freeze
      private_constant :REQUIRED_OPTIONS

      module_function

      # Parses the CLI arguments in order to fetch or determine the
      # filepaths of the survey question and response files.
      #
      # @raise [OptionParser::InvalidOptionError]
      #   if a CLI option is invalid
      # @raise [OptionParser::MissingArgumentError]
      #   if a CLI option is missing (eg -q flag without filepath)
      # @return [Array]
      #   if all arguments can be parsed correctly, an array containing
      #   the questions filepath and responses filepath is returned.
      def fetch_filepaths
        options = {}
        optparse = option_parser(options)
        optparse.parse!(ARGV)
        check_missing_options(options)
        [options[:questions_filepath], responses_filepath(options)]
      rescue OptionParser::InvalidOption, OptionParser::MissingArgument => error
        Output.error(error.to_s)
        Output.plain(optparse)
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
          Output.plain(parser)
          exit(0)
        end
      end
      private_class_method :help_option

      def version_option(parser)
        parser.on_tail("-v", "--version", "Show version") do
          Output.plain(SurveyTool::VERSION)
          exit(0)
        end
      end
      private_class_method :version_option

      def check_missing_options(options)
        missing =
          REQUIRED_OPTIONS.select do |required_option|
            options[required_option].nil?
          end
        # NOTE: I think the non-guard clause reads better here.
        # rubocop:disable Style/GuardClause
        if missing.any?
          raise OptionParser::MissingArgument, missing.join(", ")
        end
        # rubocop:enable Style/GuardClause
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
