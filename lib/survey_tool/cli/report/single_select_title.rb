module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the title
      # for "singleselect" information from a survey.
      #
      # @author Paul Fioravanti
      module SingleSelectTitle
        module_function

        # @param table [Terminal::Table]
        #   The table on which to add the row.
        def add_row(table)
          table.add_row(
            [
              {
                value: "Single Select Question Values (submitted surveys only)",
                colspan: 4,
                alignment: :center
              }
            ]
          )
        end
      end
    end
  end
end
