# frozen_string_literal: true

require "forwardable"
require_relative "survey_parser/generator"

module SurveyTool
  # Module concerned with parsing survey question and response CSV files
  # and populating question and survey objects with their information.
  #
  # @author Paul Fioravanti
  module SurveyParser
    extend Forwardable

    # @!method generate_questions
    # @return [Array]
    # @see Generator.generate_questions
    def_delegator Generator, :generate_questions
    module_function :generate_questions

    # @!method generate_survey
    # @return [Survey]
    # @see Generator.generate_survey
    def_delegator Generator, :generate_survey
    module_function :generate_survey
  end
end
