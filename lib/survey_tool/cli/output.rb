# frozen_string_literal: true

module SurveyTool
  # Module encapsulating all the functionality of the command line
  # interface to run the survey tool
  #
  # @author Paul Fioravanti
  module CLI
    # Module wrapping all functionality that outputs anything to
    # the command line.
    #
    # @author Paul Fioravanti
    module Output
      # Terminal colour code for red.
      RED = 31
      private_constant :RED

      module_function

      # Outputs the error message to `$stdout` in red, with a newline ending.
      #
      # @param message
      #   The error message to ouput.
      # @return [nil]
      def error(message)
        puts red(message)
      end

      # Outputs the message to `$stdout`, with a newline ending.
      #
      # @param message
      #   The message to ouput.
      # @return [nil]
      def plain(message)
        puts message
      end

      def red(text)
        colourize(text, colour_code: RED)
      end
      private_class_method :red

      def colourize(text, colour_code:)
        "\e[#{colour_code}m#{text}\e[0m"
      end
      private_class_method :colourize
    end
  end
end
