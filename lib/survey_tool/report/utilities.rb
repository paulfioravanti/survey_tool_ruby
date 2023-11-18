# frozen_string_literal: true

module SurveyTool
  module Report
    # Module for string manipulating functions to help format
    # information for display in the survey report table.
    #
    # @author Paul Fioravanti
    module Utilities
      # Decimal places to truncate
      NUM_DECIMAL_PLACES = 2
      private_constant :NUM_DECIMAL_PLACES
      FLOATING_POINT_NOTATION = "F"
      private_constant :FLOATING_POINT_NOTATION

      module_function

      # Takes a BigDecimal data, truncates it to 2 decimal
      # places and makes it display like a floating point number.
      #
      # @param decimal [BigDecimal]
      #   The decimal number to format for display
      # @return [String]
      #   A printable string representation of the BigDecimal number.
      def formatted_number(decimal)
        decimal.truncate(NUM_DECIMAL_PLACES).to_s(FLOATING_POINT_NOTATION)
      end

      # @param text [String]
      #   The text to wrap
      # @param line_width [Integer]
      #   The width at which to insert line breaks
      # @param break_sequence [String]
      #   The character(s) used to represent a line break
      # @return [String]
      #   The original text with any appropriate line breaks inserted.
      # NOTE: This is ripped wholesale from
      # ActionView::Helpers::TextHelper#word_wrap.
      # File actionview/lib/action_view/helpers/text_helper.rb, line 268
      def word_wrap(text, line_width: 80, break_sequence: "\n")
        # Match up to `line_width` characters, followed by one of
        #   (1) non-newline whitespace plus an optional newline
        #   (2) the end of the string, ignoring any trailing newlines
        #   (3) a newline
        #
        # -OR-
        #
        # Match an empty line
        pattern = /(.{1,#{line_width}})(?:[^\S\n]+\n?|\n*\Z|\n)|\n/

        text.gsub(pattern, "\\1#{break_sequence}").chomp!(break_sequence)
      end
    end
  end
end
