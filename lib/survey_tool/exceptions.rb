module SurveyTool
  # Error class for when the CSV file contains a question type that
  # the application does not know how to handle.
  #
  # @author Paul Fioravanti
  class UnknownQuestionTypeError < StandardError
    # @!attribute message
    # @return [String] The error message.
    attr_accessor :message

    # Initialises a new instance of the error.
    #
    # @return [UnknownQuestionTypeError]
    #   The new error instance.
    def initialize(filename, question_type)
      @message =
        "CSV file #{filename} has unknown question type '#{question_type}'"
    end
  end
end
