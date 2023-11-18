# frozen_string_literal: true

require_relative "survey_tool/cli"
require_relative "survey_tool/survey_parser"
require_relative "survey_tool/report"

# Entry point for starting the CLI application.
#
# @author Paul Fioravanti
module SurveyTool
  module_function

  # Starts the application and is the "controller" rallying point
  # for fetching all the information needed to output a survey table.
  #
  # @raise [SystemExit]
  #   if an error occurs during operation.
  # @return [nil]
  def start
    catch(:halt) { generate_report }
  rescue StandardError => error
    CLI.output(
      error: "Could not generate report: #{error.message} (#{error.class})"
    )
    exit(1)
  end

  private_class_method def generate_report
    questions_filepath, responses_filepath = CLI.fetch_filepaths
    questions = SurveyParser.generate_questions(questions_filepath)
    survey = SurveyParser.generate_survey(responses_filepath, questions)
    CLI.output(info: Report.output(survey))
  end
end
