require "terminal-table"

module SurveyTool
  module Report
    module_function

    def output(questions, responses_size, total_participant_count, participation_percentage)
      table = Terminal::Table.new do |t|
        t.title = "** SURVEY REPORT **"
        t.add_row(
          [
            {
              value: "Participation Percentage",
              colspan: 2
            },
            {
              value: "#{formatted_score(participation_percentage * 100)}%",
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
              value: "#{total_participant_count}/#{responses_size} "\
                     "responses submitted.",
              alignment: :right,
              colspan: 2
            }
          ]
        )
        if total_participant_count > 0
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
          questions.each do |question|
            t.add_separator
            t.add_row(
              [
                question.theme,
                word_wrap(question.text, 50),
                {
                  value: formatted_score(question.average_score),
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

    def formatted_score(score)
      if score
        score.truncate(2).to_s("F")
      else
        "N/A"
      end
    end
    private_class_method :formatted_score

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
