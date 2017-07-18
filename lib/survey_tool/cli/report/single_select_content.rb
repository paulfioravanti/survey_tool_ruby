require_relative "utilities"

module SurveyTool
  module CLI
    module Report
      module SingleSelectContent
        CHARACTER_LIMIT = 50
        private_constant :CHARACTER_LIMIT

        module_function

        # rubocop:disable Metrics/MethodLength
        def add_row(table:, question:)
          table.add_row(
            [
              question.theme,
              Utilities.word_wrap(question.text, CHARACTER_LIMIT),
              {
                value: formatted_answers(question.answers),
                alignment: :right,
                colspan: 2
              }
            ]
          )
        end
        # rubocop:enable Metrics/MethodLength

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
