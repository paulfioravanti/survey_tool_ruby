# frozen_string_literal: true

require "bigdecimal"

module SurveyTool
  module SurveyParser
    # Class representing a full survey with questions, their answers,
    # and other statistical information.
    #
    # @author Paul Fioravanti
    class Survey
      # @!attribute questions [r]
      # @return [Array] The collection of questions for the survey.
      attr_reader :questions

      # @!attribute participant_count [r]
      # @return [Integer]
      #   The count of responses considered to have participated in the survey.
      attr_reader :participant_count

      # @!attribute response_count [r]
      # @return [Integer]
      #   The total count of responses contained in the responses CSV file.
      attr_reader :response_count

      # Initialises a new instance of the RatingQuestion with an
      # empty collection of scores.
      #
      # @param questions [Array]
      #   The collection of questions for the survey.
      # @param participant_count [Integer]
      #   The count of responses considered to have participated
      #   in the survey.
      # @param response_count [Integer]
      #   The total count of responses contained in the responses CSV file.
      # @return [Survey]
      #   The newly initialised survey object.
      def initialize(questions, participant_count, response_count)
        @questions = questions
        @participant_count = participant_count
        @response_count = response_count
      end

      # Calculates the percentage of "participated" responses over
      # total responses.
      #
      # @return [BigDecimal]
      #   The participation percentage.
      def participation_percentage
        BigDecimal(participant_count) / BigDecimal(response_count)
      end
    end
  end
end
