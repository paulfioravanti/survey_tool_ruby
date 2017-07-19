# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the headers
      # for "singleselect" information from a survey.
      #
      # @author Paul Fioravanti
      module SingleSelectHeaders
        # Column span length
        COLUMN_SPAN = 2
        private_constant :COLUMN_SPAN

        module_function

        # Adds the column header row for SingleSelect responses.
        #
        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @return [nil]
        # rubocop:disable Metrics/MethodLength
        def add_row(table)
          table.add_row(
            [
              "Theme",
              "Selection",
              {
                value: "Values (Occurances)",
                alignment: :right,
                colspan: COLUMN_SPAN
              }
            ]
          )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
