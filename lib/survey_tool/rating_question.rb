require "bigdecimal"

module SurveyTool
  class RatingQuestion
    MAX_SCORE = 5
    private_constant :MAX_SCORE
    MIN_SCORE = 1
    private_constant :MIN_SCORE

    attr_reader :theme, :text, :scores

    def initialize(theme, text)
      @theme = theme
      @text = text
      @scores = []
    end

    def add_answer(string)
      # NOTE: I think the non-guard clause reads better here.
      # rubocop:disable Style/GuardClause
      if valid_score?(string)
        scores << string.to_i
      end
      # rubocop:enable Style/GuardClause
    end

    def average_score
      # NOTE: I think the non-guard clause reads better here.
      # rubocop:disable Style/GuardClause
      if scores.any?
        BigDecimal.new(scores.sum) / BigDecimal.new(scores.size)
      end
      # rubocop:enable Style/GuardClause
    end

    private

    def valid_score?(score)
      score.to_i.between?(MIN_SCORE, MAX_SCORE)
    end
  end
end
