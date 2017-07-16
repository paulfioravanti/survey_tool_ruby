require "test_helper"

# tests the top level survey tool module
class SurveyToolTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SurveyTool::VERSION
  end
end
