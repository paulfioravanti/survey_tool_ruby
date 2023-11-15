# frozen_string_literal: true

require "forwardable"

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

    # @!method report
    # @return [nil]
    # @see Report.output
    def_delegator Report, :output, :report
    module_function :report
  end
end
