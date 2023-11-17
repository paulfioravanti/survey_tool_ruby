# frozen_string_literal: true

module SurveyTool
  module Report
    module RatingQuestion
      # Module encapsulating configuration for displaying the headers
      # for "ratingquestion" information from a survey.
      #
      # @author Paul Fioravanti
      module Headers
        module_function

        # Returns the config for the RatingQuestion responses column header row.
        #
        # @return [Array]
        #   The configuration for the row.
        def row
          [
            "Theme",
            "Question",
            { value: "Average Score", alignment: :right },
            { value: "No. Scores Submitted", alignment: :right }
          ]
        end
      end
    end
  end
end
