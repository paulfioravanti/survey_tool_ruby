module SurveyTool
  module CLI
    module Report
      module SingleSelectTitle
        module_function

        def add_row(table:)
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
