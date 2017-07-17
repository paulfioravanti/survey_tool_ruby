require "terminal-table"
require_relative "report/participant_count"
require_relative "report/participation_percentage"
require_relative "report/rating_question_content"
require_relative "report/rating_questions_headers"
require_relative "report/rating_questions_title"

module SurveyTool
  module Report
    module_function

    def output(survey)
      table = Terminal::Table.new do |t|
        t.title = "** SURVEY REPORT **"
        ParticipationPercentage.add_row(
          table: t,
          percentage: survey.participation_percentage,
        )
        t.add_separator
        ParticipantCount.add_row(
          table: t,
          participant_count: survey.participant_count,
          response_count: survey.response_count
        )
        if survey.participant_count > 0
          t.add_separator
          RatingQuestionsTitle.add_row(table: t)
          t.add_separator
          RatingQuestionsHeaders.add_row(table: t)
          survey.questions.each do |question|
            t.add_separator
            RatingQuestionContent.add_row(table: t, question: question)
          end
        end
      end
      puts table
    end

    def formatted_number(decimal)
      if decimal
        decimal.truncate(2).to_s("F")
      else
        "N/A"
      end
    end
  end
end
