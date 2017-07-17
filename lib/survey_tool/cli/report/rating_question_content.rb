module SurveyTool
  module CLI
    module Report
      module RatingQuestionContent
        module_function

        # rubocop:disable Metrics/MethodLength
        def add_row(table:, question:)
          table.add_row(
            [
              question.theme,
              word_wrap(question.text, 50),
              {
                value: Report.formatted_number(question.average_score),
                alignment: :right
              },
              { value: question.scores.size, alignment: :right }
            ]
          )
        end
        # rubocop:enable Metrics/MethodLength

        # NOTE: Pretty much ripped wholesale from
        # ActionView::Helpers::TextHelper#word_wrap.
        # Due to that, I'll have Rubocop ignore it.
        def word_wrap(text, max_width)
          # rubocop:disable Style/MethodCalledOnDoEndBlock
          text.split("\n").map! do |line|
            if line.length > max_width
              line.gsub(/(.{1,#{max_width}})(\s+|$)/, "\\1\n").strip
            else
              line
            end
          end * "\n"
          # rubocop:enable Style/MethodCalledOnDoEndBlock
        end
        private_class_method :word_wrap
      end
    end
  end
end
