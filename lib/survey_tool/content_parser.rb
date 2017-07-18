require "csv"
require_relative "exceptions"
require_relative "rating_question"
require_relative "single_select"
require_relative "survey"

module SurveyTool
  # Module concerned with parsing question and response CSV files
  # and populating question and survey objects with their information.
  #
  # @author Paul Fioravanti
  module ContentParser
    # The range indexes of a response row that contain
    # answers to questions.
    ANSWERS_RANGE = 3..-1
    private_constant :ANSWERS_RANGE
    # The index of a response row that should contain a
    # `submitted_at` timestamp.
    TIMESTAMP_INDEX = 2
    private_constant :TIMESTAMP_INDEX

    module_function

    # Reads the entire content of a question CSV file and populates
    # appropriate objects based on the question type.
    #
    # @param csv_filepath [String]
    #   The questions CSV filepath.
    # @raise [UnknownQuestionTypeError]
    #   if the CSV file contains a type of question that is unknown to
    #   the application.
    def generate_questions(csv_filepath)
      CSV.read(csv_filepath, headers: true).map do |question|
        case question["type"]
        when "ratingquestion"
          RatingQuestion.new(question["theme"], question["text"])
        when "singleselect"
          SingleSelect.new(question["theme"], question["text"])
        else
          raise UnknownQuestionTypeError.new(csv_filepath, question["type"])
        end
      end
    end

    # Reads the responses CSV file line-by-line, inserts information
    # into question objects based on the information contained in
    # each CSV row, and then generates a Survey object to output.
    #
    # @param csv_filepath [String]
    #   The responses CSV filepath.
    # @param questions [Array]
    #   The array of question objects populated from the questions CSV file.
    # @return [Survey]
    #   The survey to output.
    def generate_survey(csv_filepath, questions)
      participant_count = 0
      response_count = 0
      CSV.foreach(csv_filepath) do |response|
        response_count += 1
        if timestamped?(response)
          participant_count += 1
          collate_answers(questions, response)
        end
      end
      Survey.new(questions, participant_count, response_count)
    end

    def collate_answers(questions, response)
      questions.zip(response[ANSWERS_RANGE]).each do |question, answer|
        question.add_answer(answer)
      end
    end
    private_class_method :collate_answers

    def timestamped?(response)
      Date.parse(response[TIMESTAMP_INDEX])
    rescue ArgumentError, TypeError
      false
    end
    private_class_method :timestamped?
  end
end
