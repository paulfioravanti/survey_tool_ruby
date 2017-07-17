module SurveyTool
  module Report
    module RatingQuestionContent
      module_function

      def add_row(table:, question:)
        table.add_row(
          [
            question.theme,
            word_wrap(question.text, 50),
            {
              value: Report.formatted_number(question.average_score),
              alignment: :right
            },
            {
              value: question.scores.size,
              alignment: :right
            }
          ]
        )
      end

      # NOTE: Pretty much ripped wholesale from
      # ActionView::Helpers::TextHelper#word_wrap
      def word_wrap(text, max_width)
        text.split("\n").map! do |line|
          if line.length > max_width
            line.gsub(/(.{1,#{max_width}})(\s+|$)/, "\\1\n").strip
          else
            line
          end
        end * "\n"
      end
      private_class_method :word_wrap
    end
  end
end
