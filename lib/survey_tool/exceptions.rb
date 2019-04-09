# frozen_string_literal: true

module SurveyTool
  # Error class for when the CSV file contains a question type that
  # the application does not know how to handle.
  #
  # @author Paul Fioravanti
  class UnknownQuestionTypeError < StandardError
    # @!attribute message [r]
    # @return [String] The error message.
    attr_reader :message

    # Initialises a new instance of the error.
    #
    # @param filename [String]
    #   The name of the file that has an unknown question type.
    # @param question_type [String]
    #   The unknown question type.
    # @return [UnknownQuestionTypeError]
    #   The new error instance.
    def initialize(filename, question_type)
      @message =
        "CSV file #{filename} has unknown question type '#{question_type}'"
    end
  end
end
