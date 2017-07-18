module SurveyTool
  module CLI
    module Report
      module RatingQuestionHeaders
        module_function

        def add_row(table:)
          table.add_row(
            [
              "Theme",
              "Question",
              { value: "Average Score", alignment: :right },
              { value: "No. Scores Submitted", alignment: :right }
            ]
          )
        end
      end
    end
  end
end
