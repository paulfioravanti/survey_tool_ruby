# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the participation
      # percentage of a survey.
      #
      # @author Paul Fioravanti
      module ParticipationPercentage
        module_function

        # Adds the survey participation percentage row to the table.
        #
        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @param percentage [BigDecimal]
        #   The survey participant percentage.
        # @return [nil]
        def add_row(table, percentage)
          table.add_row(
            [
              { value: "Participation Percentage", colspan: 2 },
              {
                value: formatted_percentage(percentage),
                alignment: :right,
                colspan: 2
              }
            ]
          )
        end

        def formatted_percentage(percentage)
          "#{Utilities.formatted_number(percentage * 100)}%"
        end
        private_class_method :formatted_percentage
      end
    end
  end
end
