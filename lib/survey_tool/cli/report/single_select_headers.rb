module SurveyTool
  module CLI
    module Report
      module SingleSelectHeaders
        module_function

        # rubocop:disable Metrics/MethodLength
        def add_row(table:)
          table.add_row(
            [
              "Theme",
              "Question",
              {
                value: "Values (No. Occurances)",
                alignment: :right,
                colspan: 2
              }
            ]
          )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
