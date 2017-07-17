module SurveyTool
  module Response
    module_function

    def has_legitimate_timestamp?(response)
      Date.parse(response[TIMESTAMP_INDEX])
    rescue ArgumentError, TypeError
      false
    end
  end
end
