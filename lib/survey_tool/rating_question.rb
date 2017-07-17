require "bigdecimal"

module SurveyTool
  class RatingQuestion
    attr_reader :theme, :text, :scores

    def initialize(theme, text)
      @theme = theme
      @text = text
      @scores = []
    end

    def average_score
      if scores.any?
        BigDecimal.new(scores.sum) / BigDecimal.new(scores.size)
      end
    end
  end
end
