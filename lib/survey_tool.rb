# frozen_string_literal: true

require "forwardable"
Dir["#{__dir__}/survey_tool/**/*.rb"].each { |file| require file }

# Top level module for survey tool
#
# @author Paul Fioravanti
module SurveyTool
  extend Forwardable

  # Delegates directly Application.start
  def_delegator Application, :start

  # Entry point for running the survey tool.
  # @!method start
  # @return (see Application.start)
  module_function :start
end
