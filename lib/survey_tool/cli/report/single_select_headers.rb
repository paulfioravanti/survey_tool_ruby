module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the headers
      # for "singleselect" information from a survey.
      #
      # @author Paul Fioravanti
      module SingleSelectHeaders
        module_function

        # @param table [Terminal::Table]
        #   The table on which to add the row.
        def add_row(table)
          table.add_row(
            [
              "Theme",
              "Selection",
              { value: "Values (Occurances)", alignment: :right, colspan: 2 }
            ]
          )
        end
      end
    end
  end
end
