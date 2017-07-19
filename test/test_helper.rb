# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "simplecov"
require "survey_tool"

require "minitest/autorun"
require "minitest/mock"
require "minitest/reporters"
Minitest::Reporters.use!
require "pry-byebug"
