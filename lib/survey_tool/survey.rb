require "bigdecimal"

module SurveyTool
  class Survey
    attr_reader :questions, :participant_count, :response_count

    def initialize(questions, participant_count, response_count)
      @questions = questions
      @participant_count = participant_count
      @response_count = response_count
    end

    def participation_percentage
      BigDecimal.new(participant_count) / BigDecimal.new(response_count)
    end
  end
end
