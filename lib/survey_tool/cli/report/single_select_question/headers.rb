# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      module SingleSelectQuestion
        # Module encapsulating configuration for displaying the headers
        # for "singleselect" information from a survey.
        #
        # @author Paul Fioravanti
        module Headers
          # Column span length
          COLUMN_SPAN = 2
          private_constant :COLUMN_SPAN

          module_function

          # Returns the config for the SingleSelect responses column header row.
          #
          # @return [Array]
          #   The configuration for the row.
          def row
            [
              "Theme",
              "Selection",
              {
                value: "Values (Occurances)",
                alignment: :right,
                colspan: COLUMN_SPAN
              }
            ]
          end
        end
      end
    end
  end
end
