require "bigdecimal"

module SurveyTool
  class Survey
    # Not sure if these in the right place
    ANSWERS_RANGE = 3..-1
    private_constant :ANSWERS_RANGE
    MAX_SCORE = 5
    private_constant :MAX_SCORE
    MIN_SCORE = 1
    private_constant :MIN_SCORE
    TIMESTAMP_INDEX = 2
    private_constant :TIMESTAMP_INDEX

    attr_reader :questions, :responses, :total_participant_count

    def initialize(questions:, responses:)
      @questions = questions
      @responses = responses
      @total_participant_count = 0
      calculate_question_scores
    end

    def participation_percentage
      BigDecimal.new(total_participant_count) / BigDecimal.new(responses.size)
    end

    def responses_size
      responses.size
    end

    private

    def calculate_question_scores
      responses.each do |response|
        if has_legitimate_timestamp?(response)
          @total_participant_count += 1
          questions.zip(response[ANSWERS_RANGE]).each do |question, answer|
            if (answer = answer.to_i).between?(MIN_SCORE, MAX_SCORE)
              question.scores << answer
            end
          end
        end
      end
    end

    # Check if survey has a "submitted at" value that is a legitimate timestamp.
    # If string is not a timestamp or value is nil, it's not legit
    def has_legitimate_timestamp?(response)
      Date.parse(response[TIMESTAMP_INDEX])
    rescue ArgumentError, TypeError
      false
    end
  end
end
