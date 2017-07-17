module SurveyTool
  # Module representing CLI colour output.
  #
  # @author Paul Fioravanti
  module Colours
    module_function

    # Wraps `text` in ASCII escape codes for red text.
    #
    # @param text [String] the text to output
    # @return [String] the colour ASCII-escaped string
    def red(text)
      colourize(text, colour_code: 31)
    end

    def colourize(text, colour_code:)
      "\e[#{colour_code}m#{text}\e[0m"
    end
    private_class_method :colourize
  end
end
