module SurveyTool
  module CLI
    # Module representing CLI output.
    #
    # @author Paul Fioravanti
    module Output
      module_function

      def error(message)
        puts red(message)
      end

      def plain(message)
        puts message
      end

      def red(text)
        colourize(text, colour_code: 31)
      end
      private_class_method :red

      def colourize(text, colour_code:)
        "\e[#{colour_code}m#{text}\e[0m"
      end
      private_class_method :colourize
    end
  end
end
