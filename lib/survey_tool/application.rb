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
    # @raise [Errno::ENOENT]
    #   if any files specified do not exist.
    # @raise [RuntimeError]
    #   if there are any issues reading or parsing the specified files.
    def start
      questions_filepath, responses_filepath =
        CLI::ArgumentParser.fetch_filepaths
      questions = ContentParser.generate_questions(questions_filepath)
      survey = ContentParser.generate_survey(responses_filepath, questions)
      CLI::Report.output(survey)
    rescue Errno::ENOENT, RuntimeError => error
      CLI::Output.error(
        "Could not generate report: #{error.message} (#{error.class})"
      )
      exit(1)
    end
  end
end
