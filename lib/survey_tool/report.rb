# frozen_string_literal: true

require "forwardable"
require_relative "report/table"

module SurveyTool
  # Module encapsulating the CLI "view" and outputting
  # information derived in the survey tool in table format.
  #
  # @author Paul Fioravanti
  module Report
    extend Forwardable

    # @!method output
    # @return [String]
    # @see Table.output
    def_delegator Table, :output
    module_function :output
  end
end
