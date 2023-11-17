# frozen_string_literal: true

require "terminal-table"
require_relative "report/participant_count"
require_relative "report/participation_percentage"
require_relative "report/rating_question"
require_relative "report/single_select_question"

module SurveyTool
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
    # @return [String]
    def output(survey)
      data =
        Terminal::Table.new(title: "** SURVEY REPORT **") do |table|
          participation_data(table, survey)
          if survey.participant_count.positive?
            survey_content_for(table, survey, "RatingQuestion")
            survey_content_for(table, survey, "SingleSelectQuestion")
          end
        end
      CLI.output(info: data)
    end

    private_class_method def participation_data(table, survey)
      table.add_row(
        ParticipationPercentage.row(survey.participation_percentage)
      )
      table.add_separator
      table.add_row(
        ParticipantCount.row(survey.participant_count, survey.response_count)
      )
    end

    private_class_method def survey_content_for(table, survey, type)
      questions = questions_of_type(survey.questions, type)
      return if questions.empty?

      survey_headers(table, type)
      survey_content(questions, table, type)
    end

    private_class_method def survey_headers(table, type)
      table.add_separator
      table.add_row(Report.const_get(type).title)
      table.add_separator
      table.add_row(Report.const_get(type).headers)
    end

    private_class_method def survey_content(questions, table, type)
      questions.each do |question|
        table.add_separator
        table.add_row(Report.const_get(type).content(question))
      end
    end

    private_class_method def questions_of_type(questions, type)
      questions.select do |question|
        question.class.name.split("::")[-1] == type
      end
    end
  end
end
