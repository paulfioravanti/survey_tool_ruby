# frozen_string_literal: true

require "bigdecimal"

module SurveyTool
  # Entry point for starting the CLI application.
  #
  # @author Paul Fioravanti
  module Application
    module_function

    # Starts the application and is the "controller" rallying point
    # for fetching all the information needed to output a survey table.
    #
    # @raise [SystemExit]
    #   if an error occurs during operation.
    # @return [nil]
    def start
      catch(:halt) { generate_report }
    rescue StandardError => e
      CLI::Output.messages(
        error: "Could not generate report: #{e.message} (#{e.class})"
      )
      exit(1)
    end

    def generate_report
      questions_filepath, responses_filepath = CLI::OptionParser.fetch_filepaths
      questions = ContentParser.generate_questions(questions_filepath)
      survey = ContentParser.generate_survey(responses_filepath, questions)
      CLI::Report.output(survey)
    end
    private_class_method :generate_report
  end
end
