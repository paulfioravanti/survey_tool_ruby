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
        # Column span length per answer
        COLUMN_SPAN = 2
        private_constant :COLUMN_SPAN

        module_function

        # Returns the config for a content row for a SingleSelect response.
        #
        # @param question [SingleSelect]
        #   The single select question to output.
        # @return [Array]
        #   The configuration for the row.
        def row(question)
          [
            question.theme,
            Utilities.word_wrap(question.text, CHARACTER_LIMIT),
            answers(question.answers)
          ]
        end

        private_class_method def answers(answers)
          {
            value: formatted_answers(answers),
            alignment: :right,
            colspan: COLUMN_SPAN
          }
        end

        private_class_method def formatted_answers(answers)
          answers =
            answers.reduce([]) do |acc, (key, value)|
              acc << "#{key} (#{value})"
            end
          answers.sort.join(", ")
        end
      end
    end
  end
end
