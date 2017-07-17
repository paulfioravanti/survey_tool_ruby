require "bigdecimal"

module SurveyTool
  Survey = Struct.new(:questions, :participant_count, :response_count) do
    def initialize(**kwargs)
      super(*members.map { |key| kwargs.fetch(key) })
      freeze
    end

    def participation_percentage
      BigDecimal.new(participant_count) / BigDecimal.new(response_count)
    end
  end
end
