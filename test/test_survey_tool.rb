# frozen_string_literal: true

require "test_helper"

class TestSurveyTool < Minitest::Test
  attr_reader :start_mock

  def setup
    # represents the return value from Application.start
    @start_mock = Minitest::Mock.new.expect(:call, :start_retval, [])
  end

  def test_start_application
    # NOTE: This tests that SurveyTool.start delegates off
    # to Application.start
    SurveyTool::Application.stub(:start, start_mock) do
      SurveyTool.start
    end
    start_mock.verify
  end
end
