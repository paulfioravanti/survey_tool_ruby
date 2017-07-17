require "bigdecimal"
require "optparse"
require_relative "report"
require_relative "argument_parser"
require_relative "csv_parser"
require_relative "version"

# The survey too omg
module SurveyTool
  module Application
    module_function

    def start
      questions_filepath, responses_filepath = ArgumentParser.fetch_filepaths
      questions = CSVParser.generate_questions(questions_filepath)
      questions, responses_size, total_participant_count =
        CSVParser.map_answers_to_questions(
          responses_filepath,
          questions
        )
      participation_percentage =
        BigDecimal.new(total_participant_count) / BigDecimal.new(responses_size)
      Report.output(
        questions,
        responses_size,
        total_participant_count,
        participation_percentage
      )
    end
  end
end
