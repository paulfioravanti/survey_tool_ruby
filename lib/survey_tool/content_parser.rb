require "csv"
require_relative "rating_question"
require_relative "survey"

module SurveyTool
  module ContentParser
    module_function

    def generate_questions(csv_filepath)
      CSV.read(csv_filepath, headers: true).map do |question|
        RatingQuestion.new(theme: question["theme"], text: question["text"])
      end
    end

    def generate_survey(csv_filepath, questions)
      responses = CSV.read(csv_filepath)
      Survey.new(questions: questions, responses: responses)
    end
  end
end
