module SurveyTool
  module CLI
    module Report
      module ParticipationPercentage
        module_function

        def add_row(table:, percentage:)
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
          "#{Report.formatted_number(percentage * 100)}%"
        end
        private_class_method :formatted_percentage
      end
    end
  end
end
