module SurveyTool
  module Report
    module RatingQuestionsHeaders
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
