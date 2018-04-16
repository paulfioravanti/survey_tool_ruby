# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "simplecov"
require "survey_tool"

require "minitest/autorun"
# NOTE: Strange issues with progress bar when focusing on a test outlined here:
# https://github.com/kern/minitest-reporters/issues/217
require "minitest/focus"
require "minitest/mock"
require "minitest/reporters"
Minitest::Reporters.use!
require "pry-byebug"
