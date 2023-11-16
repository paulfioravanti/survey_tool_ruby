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

      # Outputs the combined content of a set of message types.
      #
      # @param options [Hash]
      #   The set of messages to output
      # @option options [String] :error
      #   The message to print out as an error.
      # @option options [String] :info
      #   The message to print out as a standard message.
      # @return [String]
      def messages(**options)
        options
          .map { |type, value| __send__(type, value) }
          .join("\n")
      end

      private_class_method def info(text)
        text
      end

      private_class_method def error(text)
        colourize(text, colour_code: RED)
      end

      private_class_method def colourize(text, colour_code:)
        "\e[#{colour_code}m#{text}\e[0m"
      end
    end
  end
end
