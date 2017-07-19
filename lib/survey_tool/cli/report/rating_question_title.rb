# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the title
      # for "ratingquestion" information from a survey.
      #
      # @author Paul Fioravanti
      module RatingQuestionTitle
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
                colspan: 4,
                alignment: :center
              }
            ]
          )
        end
      end
    end
  end
end
