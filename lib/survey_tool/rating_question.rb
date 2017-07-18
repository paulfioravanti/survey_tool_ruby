require "bigdecimal"

module SurveyTool
  # Class representing a "ratingquestion" question from a CSV file.
  #
  # @author Paul Fioravanti
  class RatingQuestion
    # The maximum score allowed for a rating
    MAX_SCORE = 5
    private_constant :MAX_SCORE
    # The minimum score allowed for a rating
    MIN_SCORE = 1
    private_constant :MIN_SCORE

    # @!attribute theme [r]
    # @return [String] The theme of the question.
    attr_reader :theme

    # @!attribute text [r]
    # @return [String] The text of the question.
    attr_reader :text

    # @!attribute scores [r]
    # @return [Array] The collection of scores for the question.
    attr_reader :scores

    # Initialises a new instance of the RatingQuestion with an
    # empty collection of scores.
    #
    # @param theme [String]
    #   The theme of the question.
    # @param text [String]
    #   The text of the question.
    # @return [RatingQuestion]
    #   The newly initialised question object.
    def initialize(theme, text)
      @theme = theme
      @text = text
      @scores = []
    end

    # Validates a score before adding it to the question's
    # score collection.
    #
    # @param string [String]
    #   The score to add to the question's scores.
    def add_answer(string)
      # NOTE: I think the non-guard clause reads better here.
      # rubocop:disable Style/GuardClause
      if valid_score?(string)
        scores << string.to_i
      end
      # rubocop:enable Style/GuardClause
    end

    # Calculates the average of the question's score.
    #
    # @return [BigDecimal]
    #   The average score.
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
