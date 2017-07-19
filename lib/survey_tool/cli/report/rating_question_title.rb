# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the title
      # for "ratingquestion" information from a survey.
      #
      # @author Paul Fioravanti
      module RatingQuestionTitle
        # Column span length
        COLUMN_SPAN = 4
        private_constant :COLUMN_SPAN

        module_function

        # Adds the title row for RatingQuestion responses to the table.
        #
        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @return [nil]
        def add_row(table)
          table.add_row(
            [
              {
                value: "Rating Question Averages (submitted surveys only)",
                colspan: COLUMN_SPAN,
                alignment: :center
              }
            ]
          )
        end
      end
    end
  end
end
