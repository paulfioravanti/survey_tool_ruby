require "survey_tool/version"
require "csv"
require "bigdecimal"
require "terminal-table"

# class Question
#   attr_reader :theme, :text
#   attr_accessor :scores

#   def initialize(theme:, text:)
#     @theme = theme
#     @text = text
#     @scores = []
#   end

#   def average_score
#     return nil if scores.empty?
#     BigDecimal.new(answers.sum) / BigDecimal.new(answers.size)
#   end
# end

# The survey too omg
module SurveyTool
  module_function

  def output_results
    questions = CSV.read("example-data/survey-2.csv", headers: true)
    questions =
      questions.map do |question|
        Struct.new(*question.headers.map(&:to_sym), :answers) do
          def average_score
            if type != "ratingquestion" || answers.empty?
              return nil
            end
            (BigDecimal.new(answers.sum) / BigDecimal.new(answers.size))
          end
        end.new(*question.fields, [])
      end

    responses = CSV.read("example-data/survey-2-responses.csv")
    total_participant_count = 0
    responses.each do |response|
      begin
        # Check if survey has a "submitted at" value
        # that is a legitimate timestamp
        if Date.parse(response[2])
          total_participant_count += 1
          questions.zip(response[3..-1]).each do |question, answer|
            if (answer = answer.to_i).between?(1, 5)
              question.answers << answer
            end
          end
        end
      # Rescue if string is not a timestamp or value is nil
      rescue ArgumentError, TypeError
        next
      end
    end

    participation_percentage =
      BigDecimal.new(total_participant_count) / BigDecimal.new(responses.size)

    table = Terminal::Table.new(title: " ** SURVEY REPORT **") do |t|
      t.add_row(
        [
          {
            value: "Participation Percentage",
            colspan: 2
          },
          {
            value: "#{(participation_percentage * 100).truncate(2).to_s("F")}%",
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
            value: "#{total_participant_count}/#{responses.size} responses submitted.",
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
            { value: "No. Answers Submitted", alignment: :right }
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
                value: question.answers.size,
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
end
