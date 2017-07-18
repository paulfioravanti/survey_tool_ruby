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
              survey_content(table, survey)
            end
          end
        Output.plain(data)
      end

      def formatted_number(decimal)
        if decimal
          decimal.truncate(2).to_s("F")
        else
          "N/A"
        end
      end

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

      def survey_content(table, survey)
        table.add_separator
        if (questions = questions_of_type(survey.questions, RatingQuestion)).any?
          RatingQuestionTitle.add_row(table: table)
          table.add_separator
          RatingQuestionHeaders.add_row(table: table)
          questions.each do |question|
            table.add_separator
            RatingQuestionContent.add_row(table: table, question: question)
          end
          table.add_separator
        end
        if (questions = questions_of_type(survey.questions, SingleSelect)).any?
          SingleSelectTitle.add_row(table: table)
          table.add_separator
          SingleSelectHeaders.add_row(table: table)
          questions.each do |question|
            table.add_separator
            SingleSelectContent.add_row(table: table, question: question)
          end
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
