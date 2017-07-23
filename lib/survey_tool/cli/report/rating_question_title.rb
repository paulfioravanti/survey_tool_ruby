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

        # Returns the config for RatingQuestion response title row.
        #
        # @return [Array]
        #   The configuration for the row.
        def row
          [
            {
              value: "Rating Question Averages (submitted surveys only)",
              colspan: COLUMN_SPAN,
              alignment: :center
            }
          ]
        end
      end
    end
  end
end
