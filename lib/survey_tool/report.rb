require "terminal-table"

module SurveyTool
  module Report
    module_function

    def output(survey)
      table = Terminal::Table.new do |t|
        t.title = "** SURVEY REPORT **"
        t.add_row(
          [
            {
              value: "Participation Percentage",
              colspan: 2
            },
            {
              value: formatted_percentage(survey.participation_percentage),
              alignment: :right,
              colspan: 2
            }
          ]
        )
        t.add_separator
        t.add_row(
          [
            {
              value: "Total Participant Count",
              colspan: 2
            },
            {
              value: "#{survey.total_participant_count}/"\
                     "#{survey.responses_size} responses submitted.",
              alignment: :right,
              colspan: 2
            }
          ]
        )
        if survey.total_participant_count > 0
          t.add_separator
          t.add_row(
            [
              {
                value: "Rating Question Averages (submitted surveys only)",
                colspan: 4,
                alignment: :center
              }
            ]
          )
          t.add_separator
          t.add_row(
            [
              "Theme",
              "Question",
              { value: "Average Score", alignment: :right },
              { value: "No. Scores Submitted", alignment: :right }
            ]
          )
          survey.questions.each do |question|
            t.add_separator
            t.add_row(
              [
                question.theme,
                word_wrap(question.text, 50),
                {
                  value: formatted_number(question.average_score),
                  alignment: :right
                },
                {
                  value: question.scores.size,
                  alignment: :right
                }
              ]
            )
          end
        end
      end
      puts table
    end

    def formatted_percentage(percentage)
      "#{formatted_number(percentage * 100)}%"
    end
    private_class_method :formatted_percentage

    def formatted_number(decimal)
      if decimal
        decimal.truncate(2).to_s("F")
      else
        "N/A"
      end
    end
    private_class_method :formatted_number

    # NOTE: Pretty much ripped from ActionView::Helpers::TextHelper#word_wrap
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
