require "csv"
require_relative "rating_question"

module SurveyTool
  module CSVParser
    module_function

    def generate_questions(csv_filepath)
      CSV.read(csv_filepath, headers: true).map do |question|
        RatingQuestion.new(theme: question["theme"], text: question["text"])
      end
    end

    def map_answers_to_questions(csv_filepath, questions)
      responses = CSV.read(csv_filepath)
      total_participant_count = 0
      responses.each do |response|
        if has_legitimate_timestamp?(response)
          total_participant_count += 1
          questions.zip(survey_answers(response)).each do |question, score|
            if (score = score.to_i).between?(1, 5)
              question.scores << score
            end
          end
        end
      end
      [questions, responses.size, total_participant_count]
    end

    # Check if survey has a "submitted at" value that is a legitimate timestamp
    def has_legitimate_timestamp?(response)
      Date.parse(response[2])
    rescue ArgumentError, TypeError
      # Rescue if string is not a timestamp or value is nil
      false
    end
    private_class_method :has_legitimate_timestamp?

    def survey_answers(response)
      # Each column from the fourth onwards are responses to survey questions.
      response[3..-1]
    end
    private_class_method :survey_answers
  end
end
