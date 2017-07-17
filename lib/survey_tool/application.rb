require "bigdecimal"
require_relative "cli/argument_parser"
require_relative "cli/report"
require_relative "content_parser"

# The survey too omg
module SurveyTool
  module Application
    module_function

    def start
      questions_filepath, responses_filepath =
        CLI::ArgumentParser.fetch_filepaths
      questions = ContentParser.generate_questions(questions_filepath)
      survey = ContentParser.generate_survey(responses_filepath, questions)
      CLI::Report.output(survey)
    end
  end
end
