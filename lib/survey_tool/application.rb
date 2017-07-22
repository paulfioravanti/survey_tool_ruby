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
    # rubocop:disable Metrics/MethodLength
    def start
      catch(:halt) do
        questions_filepath, responses_filepath =
          CLI::OptionParser.fetch_filepaths
        questions = ContentParser.generate_questions(questions_filepath)
        survey = ContentParser.generate_survey(responses_filepath, questions)
        CLI::Report.output(survey)
      end
    rescue StandardError => error
      CLI::Output.messages(
        error: "Could not generate report: #{error.message} (#{error.class})"
      )
      exit(1)
    end
    # rubocop:enable Metrics/MethodLength
  end
end
