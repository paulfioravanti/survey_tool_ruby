module SurveyTool
  module CLI
    module Report
      module Utilities
        module_function

        def formatted_number(decimal)
          if decimal
            decimal.truncate(2).to_s("F")
          else
            "N/A"
          end
        end

        # NOTE: Pretty much ripped wholesale from
        # ActionView::Helpers::TextHelper#word_wrap.
        # Due to that, I'll have Rubocop ignore it.
        def word_wrap(text, max_width)
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
