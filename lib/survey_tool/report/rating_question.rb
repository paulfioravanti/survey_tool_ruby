# frozen_string_literal: true

require "forwardable"
require_relative "rating_question/content"
require_relative "rating_question/headers"
require_relative "rating_question/title"

module SurveyTool
  module Report
    # Module encapsulating configuration for a "ratingquestion" question
    # from a survey.
    #
    # @author Paul Fioravanti
    module RatingQuestion
      extend Forwardable

      # @!method title
      # @return [Array]
      # @see Title.row
      def_delegator Title, :row, :title
      module_function :title

      # @!method headers
      # @return [Array]
      # @see Headers.row
      def_delegator Headers, :row, :headers
      module_function :headers

      # @!method content
      # @return [Array]
      # @see Content.row
      def_delegator Content, :row, :content
      module_function :content
    end
  end
end
