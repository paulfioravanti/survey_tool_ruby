# frozen_string_literal: true

require "forwardable"
Dir["#{__dir__}/survey_tool/**/*.rb"].each { |file| require file }

# Top level module for survey tool
#
# @author Paul Fioravanti
module SurveyTool
  extend Forwardable

  # @!method start
  #   Entry point for running the survey tool.
  #
  #   @return [nil]
  #   @see Application.start
  def_delegator Application, :start

  module_function :start
end
