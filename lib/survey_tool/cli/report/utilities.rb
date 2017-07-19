# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module for string manipulating functions to help format
      # information for display in the survey report table.
      #
      # @author Paul Fioravanti
      module Utilities
        module_function

        # Takes a BigDecimal data, truncates it to 2 decimal
        # places and makes it display like a floating point number.
        #
        # @param decimal [BigDecimal]
        #   The decimal number to format for display
        # @return [String]
        #   A printable string representation of the BigDecimal number.
        def formatted_number(decimal)
          decimal.truncate(2).to_s("F")
        end

        # @param text [String]
        #   The text to wrap
        # @param max_width [Integer]
        #   The width at which to insert line breaks
        # @return [String]
        #   The original text with any appropriate line breaks inserted.
        def word_wrap(text, max_width)
          # NOTE: This is ripped wholesale from
          # ActionView::Helpers::TextHelper#word_wrap.
          # Due to that, have Rubocop ignore it.
          # rubocop:disable Style/MethodCalledOnDoEndBlock
          text.split("\n").map! do |line|
            if line.length > max_width
              line.gsub(/(.{1,#{max_width}})(\s+|$)/, "\\1\n").strip
            else
              line
            end
          end * "\n"
          # rubocop:enable Style/MethodCalledOnDoEndBlock
        end
      end
    end
  end
end
