# frozen_string_literal: true

require "csv"

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
    # NOTE: I think making this method shorter will affect its readability
    # given the nature of the `case` statement.
    # rubocop:disable Metrics/MethodLength
    def generate_questions(csv_filepath)
      CSV.read(csv_filepath, headers: true).map do |question|
        type, theme, text = question.values_at("type", "theme", "text")
        case type
        when "ratingquestion"
          RatingQuestion.new(theme, text)
        when "singleselect"
          SingleSelect.new(theme, text)
        else
          raise UnknownQuestionTypeError.new(csv_filepath, type)
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

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
      participant_count = response_count = 0
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
