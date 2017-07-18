require "csv"
require_relative "exceptions"
require_relative "rating_question"
require_relative "single_select"
require_relative "survey"

module SurveyTool
  module ContentParser
    ANSWERS_RANGE = 3..-1
    private_constant :ANSWERS_RANGE
    TIMESTAMP_INDEX = 2
    private_constant :TIMESTAMP_INDEX

    module_function

    def generate_questions(csv_filepath)
      CSV.read(csv_filepath, headers: true).map do |question|
        case question["type"]
        when "ratingquestion"
          RatingQuestion.new(question["theme"], question["text"])
        when "singleselect"
          SingleSelect.new(question["theme"], question["text"])
        else
          raise UnknownQuestionTypeError.new(csv_filepath, question["type"])
        end
      end
    end

    def generate_survey(csv_filepath, questions)
      participant_count = 0
      response_count = 0
      CSV.foreach(csv_filepath) do |response|
        response_count += 1
        if timestamped?(response)
          participant_count += 1
          collate_answers(questions, response)
        end
      end
      Survey.new(questions, participant_count, response_count)
    end

    def collate_answers(questions, response)
      questions.zip(response[ANSWERS_RANGE]).each do |question, answer|
        question.add_answer(answer)
      end
    end
    private_class_method :collate_answers

    def timestamped?(response)
      Date.parse(response[TIMESTAMP_INDEX])
    rescue ArgumentError, TypeError
      false
    end
    private_class_method :timestamped?
  end
end
