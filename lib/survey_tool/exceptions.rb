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
    # @return [UnknownQuestionTypeError]
    #   The new error instance.
    def initialize(filename, question_type)
      @message =
        "CSV file #{filename} has unknown question type '#{question_type}'"
    end
  end

  # Error class for when a CSV file does not contain headers but they were
  # expected.  Ruby's CSV class does not raise any errors when the
  # headers: true option is passed to CSV.read: they just get ignored
  #
  # @author Paul Fioravanti
  class MissingHeadersError < StandardError
    # @!attribute message [r]
    # @return [String] The error message.
    attr_reader :message

    # Initialises a new instance of the error.
    #
    # @return [MissingHeadersError]
    #   The new error instance.
    def initialize(filename)
      @message = "CSV file #{filename} is missing headers."
    end
  end
end
