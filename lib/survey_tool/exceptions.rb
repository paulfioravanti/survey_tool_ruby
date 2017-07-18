module SurveyTool
  class UnknownQuestionTypeError < StandardError
    attr_accessor :message

    def initialize(filename, question_type)
      @message =
        "CSV file #{filename} has unknown question type '#{question_type}'"
    end
  end
end
