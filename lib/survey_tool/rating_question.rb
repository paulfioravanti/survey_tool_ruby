require "bigdecimal"

module SurveyTool
  RatingQuestion =
    Struct.new(:theme, :text, :scores) do
      def initialize(*args, &block)
        super(*args, &block)
        self.scores = []
        freeze
      end

      def average_score
        return nil if scores.empty?
        BigDecimal.new(scores.sum) / BigDecimal.new(scores.size)
      end
    end
end
