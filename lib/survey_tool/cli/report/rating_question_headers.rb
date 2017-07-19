# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the headers
      # for "ratingquestion" information from a survey.
      #
      # @author Paul Fioravanti
      module RatingQuestionHeaders
        module_function

        # Adds the column header row for RatingQuestion responses.
        #
        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @return [nil]
        def add_row(table)
          table.add_row(
            [
              "Theme",
              "Question",
              { value: "Average Score", alignment: :right },
              { value: "No. Scores Submitted", alignment: :right }
            ]
          )
        end
      end
    end
  end
end
