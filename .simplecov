# frozen_string_literal: true

# Only run coverage when running spec suite outside of Guard
# NOTE: This is an ENV variable so all the values are strings.
unless ENV["NO_COVERAGE"] == "true"
  SimpleCov.start do
    add_filter "/test/"
    # NOTE: Switch out these statements dependent on whether
    # very active development is occurring or not.
    # SimpleCov.minimum_coverage 100
    # SimpleCov.refuse_coverage_drop
  end
end
