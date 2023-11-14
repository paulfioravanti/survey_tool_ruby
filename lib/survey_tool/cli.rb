# frozen_string_literal: true

module SurveyTool
  # Module encapsulating all the functionality of the command line
  # interface to run the survey tool
  #
  # @author Paul Fioravanti
  module CLI
    module_function

    def output(**)
      Output.messages(**)
    end
  end
end
