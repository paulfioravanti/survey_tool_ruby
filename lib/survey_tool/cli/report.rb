require "terminal-table"
require_relative "report/participant_count"
require_relative "report/participation_percentage"
require_relative "report/rating_question_content"
require_relative "report/rating_question_headers"
require_relative "report/rating_question_title"
require_relative "report/single_select_content"
require_relative "report/single_select_headers"
require_relative "report/single_select_title"

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
              survey_content_for(table, survey, "RatingQuestion")
              survey_content_for(table, survey, "SingleSelect")
            end
          end
        Output.plain(data)
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

      def survey_content_for(table, survey, type)
        questions =
          questions_of_type(survey.questions, SurveyTool.const_get(type))
        return if questions.empty?
        survey_headers(table, type)
        survey_content(questions, table, type)
      end

      def survey_headers(table, type)
        table.add_separator
        Report.const_get("#{type}Title").add_row(table: table)
        table.add_separator
        Report.const_get("#{type}Headers").add_row(table: table)
      end
      private_class_method :survey_headers

      def survey_content(questions, table, type)
        questions.each do |question|
          table.add_separator
          Report.const_get("#{type}Content").add_row(
            table: table,
            question: question
          )
        end
      end
      private_class_method :survey_content

      def questions_of_type(questions, type)
        questions.select { |question| question.is_a?(type) }
      end
      private_class_method :questions_of_type
    end
  end
end