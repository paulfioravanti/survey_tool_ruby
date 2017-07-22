# frozen_string_literal: true

module SurveyTool
  module CLI
    module Report
      # Module encapsulating configuration for displaying the participant
      # count of a survey.
      #
      # @author Paul Fioravanti
      module ParticipantCount
        # Column span length
        COLUMN_SPAN = 2
        private_constant :COLUMN_SPAN

        module_function

        # Returns the config for the participant count report row.
        #
        # @param participant_count [Integer]
        #   The survey participant count
        # @param response_count [Integer]
        #   The survey response count
        # @return [nil]
        def row(participant_count, response_count)
          [
            { value: "Participant Count", colspan: COLUMN_SPAN },
            {
              value: "#{participant_count}/#{response_count} submitted.",
              alignment: :right,
              colspan: COLUMN_SPAN
            }
          ]
        end
      end
    end
  end
end
