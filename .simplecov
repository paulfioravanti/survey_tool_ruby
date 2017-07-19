# Only run coverage when running spec suite outside of Guard
unless ENV["NO_COVERAGE"]
  SimpleCov.start do
    add_filter "/test/"
    SimpleCov.minimum_coverage 100
  end
end
