require_relative "utilities"

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the content
      # of a "ratingquestion" question from a survey.
      #
      # @author Paul Fioravanti
      module RatingQuestionContent
        # Specified character limit for wrapping content in a table cell.
        CHARACTER_LIMIT = 50
        private_constant :CHARACTER_LIMIT

        module_function

        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @param question [RatingQuestion]
        #   The rating question to output.
        def add_row(table, question)
          table.add_row(
            [
              question.theme,
              Utilities.word_wrap(question.text, CHARACTER_LIMIT),
              average_score(question),
              { value: question.scores.size, alignment: :right }
            ]
          )
        end

        def average_score(question)
          {
            value: Utilities.formatted_number(question.average_score),
            alignment: :right
          }
        end
        private_class_method :average_score
      end
    end
  end
end
