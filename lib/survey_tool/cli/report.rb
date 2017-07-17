require "terminal-table"
require_relative "report/participant_count"
require_relative "report/participation_percentage"
require_relative "report/rating_question_content"
require_relative "report/rating_questions_headers"
require_relative "report/rating_questions_title"

module SurveyTool
  module CLI
    module Report
      module_function

      def output(survey)
        data =
          Terminal::Table.new do |table|
            table.title = "** SURVEY REPORT **"
            participation_data(table, survey)
            if survey.participant_count.positive?
              rating_questions_content(table, survey)
            end
          end
        puts data
      end

      def formatted_number(decimal)
        if decimal
          decimal.truncate(2).to_s("F")
        else
          "N/A"
        end
      end

      def participation_data(table, survey)
        ParticipationPercentage.add_row(
          table: table,
          percentage: survey.participation_percentage
        )
        table.add_separator
        ParticipantCount.add_row(
          table: table,
          participant_count: survey.participant_count,
          response_count: survey.response_count
        )
      end

      def rating_questions_content(table, survey)
        table.add_separator
        RatingQuestionsTitle.add_row(table: table)
        table.add_separator
        RatingQuestionsHeaders.add_row(table: table)
        survey.questions.each do |question|
          table.add_separator
          RatingQuestionContent.add_row(table: table, question: question)
        end
      end
      private_class_method :rating_questions_content
    end
  end
end
