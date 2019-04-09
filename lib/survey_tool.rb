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

  # @!method start
  #   Entry point for running the survey tool.
  #
  #   @return [nil]
  #   @see Application.start
  # False positive: https://github.com/rubocop-hq/rubocop/issues/5953
  # rubocop:disable Style/AccessModifierDeclarations
  module_function :start
  # rubocop:enable Style/AccessModifierDeclarations
end
