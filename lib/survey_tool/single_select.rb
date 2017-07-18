module SurveyTool
  # Class representing a "singleselect" question from a CSV file.
  #
  # @author Paul Fioravanti
  class SingleSelect
    # @!attribute theme [r]
    # @return [String] The theme of the question.
    attr_reader :theme

    # @!attribute text [r]
    # @return [String] The text of the question.
    attr_reader :text

    # @!attribute scores [r]
    # @return [Hash] The collection of tallied answers for the question.
    attr_reader :answers

    # Initialises a new instance of the SingleSelect with an
    # empty collection of answers.
    #
    # @param theme [String]
    #   The theme of the question.
    # @param text [String]
    #   The text of the question.
    # @return [RatingQuestion]
    #   The newly initialised question object.
    def initialize(theme, text)
      @theme = theme
      @text = text
      @answers = {}
    end

    # Adds a value to the question's answer collection,
    # keeping a tally of each value's occurrence.
    #
    # @param string [String]
    #   The value to add to the question's answers.
    def add_answer(string)
      answers.key?(string) ? answers[string] += 1 : answers[string] = 1
    end
  end
end
