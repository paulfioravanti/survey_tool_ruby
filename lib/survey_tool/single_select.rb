module SurveyTool
  class SingleSelect
    attr_reader :theme, :text, :answers

    def initialize(theme, text)
      @theme = theme
      @text = text
      @answers = {}
    end

    def add_answer(string)
      answers.key?(string) ? answers[string] += 1 : answers[string] = 1
    end
  end
end
