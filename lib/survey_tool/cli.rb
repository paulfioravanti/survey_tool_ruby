# frozen_string_literal: true

require "forwardable"
require_relative "cli/option_parser"
require_relative "cli/output"

module SurveyTool
  # Module encapsulating all the functionality of the command line
  # interface to run the survey tool
  #
  # @author Paul Fioravanti
  module CLI
    extend Forwardable

    # @!method fetch_filepaths
    # @return [Array]
    # @see OptionParser.fetch_filepaths
    def_delegator OptionParser, :fetch_filepaths
    module_function :fetch_filepaths

    # @!method output
    # @return [nil]
    # @see Output.messages
    def_delegator Output, :messages, :output
    module_function :output
  end
end
