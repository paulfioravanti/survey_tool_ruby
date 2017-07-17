module SurveyTool
  module Report
    module RatingQuestionsTitle
      module_function

      def add_row(table:)
        table.add_row(
          [
            {
              value: "Rating Question Averages (submitted surveys only)",
              colspan: 4,
              alignment: :center
            }
          ]
        )
      end
    end
  end
end
