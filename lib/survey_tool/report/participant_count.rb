module SurveyTool
  module Report
    module ParticipantCount
      module_function

      def add_row(table:, participant_count:, response_count:)
        table.add_row(
          [
            {
              value: "Participant Count",
              colspan: 2
            },
            {
              value: "#{participant_count}/"\
                     "#{response_count} responses submitted.",
              alignment: :right,
              colspan: 2
            }
          ]
        )
      end
    end
  end
end
