require "bigdecimal"
require_relative "report"
require_relative "argument_parser"
require_relative "content_parser"
require_relative "version"

# The survey too omg
module SurveyTool
  module Application
    module_function

    def start
      questions_filepath, responses_filepath =
        ArgumentParser.fetch_filepaths
      questions =
        ContentParser.generate_questions(questions_filepath)
      survey =
        ContentParser.generate_survey(responses_filepath, questions)
      Report.output(survey)
    end
  end
end
