module SurveyTool
  module CLI
    module Report
      module ParticipantCount
        module_function

        # rubocop:disable Metrics/MethodLength
        def add_row(table:, participant_count:, response_count:)
          table.add_row(
            [
              { value: "Participant Count", colspan: 2 },
              {
                value: "#{participant_count}/"\
                       "#{response_count} responses submitted.",
                alignment: :right,
                colspan: 2
              }
            ]
          )
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
