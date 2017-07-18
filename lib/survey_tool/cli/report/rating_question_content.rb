require_relative "utilities"

module SurveyTool
  module CLI
    module Report
      module RatingQuestionContent
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
                value: Utilities.formatted_number(question.average_score),
                alignment: :right
              },
              { value: question.scores.size, alignment: :right }
            ]
          )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
