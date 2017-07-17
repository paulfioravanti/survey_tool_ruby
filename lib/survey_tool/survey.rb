require "bigdecimal"

module SurveyTool
  Survey =
    Struct.new(:questions, :participant_count, :response_count) do
      def initialize(*args, &block)
        super(*args, &block)
        freeze
      end

      def participation_percentage
        BigDecimal.new(participant_count) / BigDecimal.new(response_count)
      end
    end
end
