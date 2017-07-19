# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the participant
      # count of a survey.
      #
      # @author Paul Fioravanti
      module ParticipantCount
        module_function

        # @param table [Terminal::Table]
        #   The table on which to add the row.
        # @param participant_count [Integer]
        #   The survey participant count
        # @param response_count [Integer]
        #   The survey response count
        def add_row(table, participant_count, response_count)
          table.add_row(
            [
              { value: "Participant Count", colspan: 2 },
              {
                value: "#{participant_count}/#{response_count} submitted.",
                alignment: :right,
                colspan: 2
              }
            ]
          )
        end
      end
    end
  end
end
