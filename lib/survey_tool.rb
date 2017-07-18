require "forwardable"
require_relative "survey_tool/application"

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
