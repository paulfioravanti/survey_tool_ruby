require "csv"
require_relative "rating_question"
require_relative "survey"

module SurveyTool
  module ContentParser
    ANSWERS_RANGE = 3..-1
    private_constant :ANSWERS_RANGE
    MAX_SCORE = 5
    private_constant :MAX_SCORE
    MIN_SCORE = 1
    private_constant :MIN_SCORE
    TIMESTAMP_INDEX = 2
    private_constant :TIMESTAMP_INDEX

    module_function

    def generate_questions(csv_filepath)
      CSV.read(csv_filepath, headers: true).map do |question|
        RatingQuestion.new(question["theme"], question["text"])
      end
    end

    def generate_survey(csv_filepath, questions)
      participant_count = 0
      response_count = 0
      CSV.foreach(csv_filepath) do |response|
        response_count += 1
        if timestamped?(response)
          participant_count += 1
          questions.zip(response[ANSWERS_RANGE]).each do |question, answer|
            if valid_answer?(answer)
              question.scores << answer.to_i
            end
          end
        end
      end
      Survey.new(
        questions: questions,
        participant_count: participant_count,
        response_count: response_count
      )
    end

    def timestamped?(response)
      Date.parse(response[TIMESTAMP_INDEX])
    rescue ArgumentError, TypeError
      false
    end
    private_class_method :timestamped?

    def valid_answer?(answer)
      answer.to_i.between?(MIN_SCORE, MAX_SCORE)
    end
    private_class_method :valid_answer?
  end
end
