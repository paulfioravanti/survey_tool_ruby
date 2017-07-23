# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the participation
      # percentage of a survey.
      #
      # @author Paul Fioravanti
      module ParticipationPercentage
        # Column span length
        COLUMN_SPAN = 2
        private_constant :COLUMN_SPAN
        # Percent multiplier for formatting
        PERCENT_MULTIPLIER = 100
        private_constant :PERCENT_MULTIPLIER

        module_function

        # Returns the config for the participation percentage report row.
        #
        # @param percentage [BigDecimal]
        #   The survey participant percentage.
        # @return [Array]
        #   The configuration for the row.
        def row(percentage)
          [
            { value: "Participation Percentage", colspan: COLUMN_SPAN },
            {
              value: formatted_percentage(percentage),
              alignment: :right,
              colspan: COLUMN_SPAN
            }
          ]
        end

        def formatted_percentage(percentage)
          "#{Utilities.formatted_number(percentage * PERCENT_MULTIPLIER)}%"
        end
        private_class_method :formatted_percentage
      end
    end
  end
end
