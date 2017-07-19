# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the content
      # of a "singleselect" question from a survey.
      #
      # @author Paul Fioravanti
      module SingleSelectContent
        # Specified character limit for wrapping content in a table cell.
        CHARACTER_LIMIT = 50
        private_constant :CHARACTER_LIMIT

        module_function

        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @param question [SingleSelect]
        #   The single select question to output.
        def add_row(table, question)
          table.add_row(
            [
              question.theme,
              Utilities.word_wrap(question.text, CHARACTER_LIMIT),
              answers(question.answers)
            ]
          )
        end

        def answers(answers)
          {
            value: formatted_answers(answers),
            alignment: :right,
            colspan: 2
          }
        end
        private_class_method :answers

        def formatted_answers(answers)
          answers =
            answers.reduce([]) do |array, (key, value)|
              array << "#{key} (#{value})"
            end
          answers.sort.join(", ")
        end
        private_class_method :formatted_answers
      end
    end
  end
end
