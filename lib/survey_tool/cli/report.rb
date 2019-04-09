# frozen_string_literal: true

require "terminal-table"

module SurveyTool
  module CLI
    # Module encapsulating the CLI "view" and outputting
    # information derived in the survey tool in table format.
    #
    # @author Paul Fioravanti
    module Report
      module_function

      # Output the survey data to `$stdout`.
      #
      # @param survey [Survey]
      #   The survey to output.
      # @return [nil]
      def output(survey)
        data =
          Terminal::Table.new(title: "** SURVEY REPORT **") do |table|
            participation_data(table, survey)
            if survey.participant_count.positive?
              survey_content_for(table, survey, "RatingQuestion")
              survey_content_for(table, survey, "SingleSelect")
            end
          end
        Output.messages(info: data)
      end

      def participation_data(table, survey)
        table.add_row(
          ParticipationPercentage.row(survey.participation_percentage)
        )
        table.add_separator
        table.add_row(
          ParticipantCount.row(survey.participant_count, survey.response_count)
        )
      end
      private_class_method :participation_data

      def survey_content_for(table, survey, type)
        questions =
          questions_of_type(survey.questions, SurveyTool.const_get(type))
        return if questions.empty?

        survey_headers(table, type)
        survey_content(questions, table, type)
      end
      private_class_method :survey_content_for

      def survey_headers(table, type)
        table.add_separator
        table.add_row(Report.const_get("#{type}Title").row)
        table.add_separator
        table.add_row(Report.const_get("#{type}Headers").row)
      end
      private_class_method :survey_headers

      def survey_content(questions, table, type)
        questions.each do |question|
          table.add_separator
          table.add_row(Report.const_get("#{type}Content").row(question))
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
