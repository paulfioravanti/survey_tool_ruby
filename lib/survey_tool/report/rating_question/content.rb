# frozen_string_literal: true

require_relative "../utilities"

module SurveyTool
  module Report
    module RatingQuestion
      # Module encapsulating configuration for displaying the content
      # of a "ratingquestion" question from a survey.
      #
      # @author Paul Fioravanti
      module Content
        # Specified character limit for wrapping content in a table cell.
        CHARACTER_LIMIT = 50
        private_constant :CHARACTER_LIMIT

        module_function

        # Returns the config for a content row for a RatingQuestion response.
        #
        # @param question [RatingQuestion]
        #   The rating question to output.
        # @return [Array]
        #   The configuration for the row.
        def row(question)
          [
            question.theme,
            Utilities.word_wrap(question.text, CHARACTER_LIMIT),
            average_score(question),
            { value: question.scores.size, alignment: :right }
          ]
        end

        private_class_method def average_score(question)
          {
            value: Utilities.formatted_number(question.average_score),
            alignment: :right
          }
        end
      end
    end
  end
end
