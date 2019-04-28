[![Build Status][travis-badge]][travis-url]
[![Code Climate][code-climate-badge]][code-climate-url]
[![Coverage][code-climate-coverage-badge]][code-climate-coverage-url]
[![Inline docs][inch-badge]][inch-url]

[comment]: # (Some services aren't working, so for now, hide their badges.)
[git.legal]: # ([![git.legal][git-legal-badge]][git-legal-url])

# CSV Survey Tool Developer Coding Test

A [Ruby][] CLI application that parses and displays survey data from CSV files,
and displays the results.

## Setup

    $ git clone https://github.com/paulfioravanti/survey_tool_ruby.git
    $ cd survey_tool_ruby
    $ bundle install

## Usage

Run the application with the following command:

    $ bin/survey-tool -q questions.csv [-r responses.csv]

If the survey responses CSV file is _not_ specified, it will attempt to be
inferred.  For example, if the questions CSV file is named
`path/to/questions.csv`, then the application will attempt to use
`path/to/questions-responses.csv` for the responses file.

Other options can be seen by running the help command:

    $ bin/survey-tool -h

## Development

### Dependencies

- Ruby 2.6.3

### Environment

Heavy use of [Guard][] was made during development to ensure code quality,
so I highly recommend having the following commands running in other
terminal windows:

    $ bin/guard -w lib test
    $ bin/console

## Tests

[Minitest][] was used for the tests, which can be run with the
following command:

    $ bin/rake test

## Coverage Report

View the [Simplecov][] test coverage report (after running the tests):

    $ open coverage/index.html

## Application Documentation

Generate the [YARD][] documentation (after running the tests) and open it:

    $ bin/yardoc
    $ open doc/index.html

## Other

I also wrote a version of this app in [Elixir][], which can be found
[here][survey-tool-elixir].

## Social

[![Contact][twitter-badge]][twitter-url]<br />
[![Stack Overflow][stackoverflow-badge]][stackoverflow-url]

[code-climate-badge]: https://codeclimate.com/github/paulfioravanti/survey_tool_ruby/badges/gpa.svg
[code-climate-coverage-badge]: https://codeclimate.com/github/paulfioravanti/survey_tool_ruby/badges/coverage.svg
[code-climate-coverage-url]: https://codeclimate.com/github/paulfioravanti/survey_tool_ruby
[code-climate-url]: https://codeclimate.com/github/paulfioravanti/survey_tool_ruby
[Elixir]: https://github.com/elixir-lang/elixir
[git-legal-badge]: https://git.legal/projects/4738/badge.svg?key=6a6b2594f976e68abe3a "Number of libraries approved"
[git-legal-url]: https://git.legal/projects/4738
[Guard]: https://github.com/guard/guard/
[inch-badge]: http://inch-ci.org/github/paulfioravanti/survey_tool_ruby.svg
[inch-url]: http://inch-ci.org/github/paulfioravanti/survey_tool_ruby
[Minitest]: https://github.com/seattlerb/minitest
[Ruby]: https://github.com/ruby/ruby
[Simplecov]: https://github.com/colszowka/simplecov
[stackoverflow-badge]: http://stackoverflow.com/users/flair/567863.png
[stackoverflow-url]: http://stackoverflow.com/users/567863/paul-fioravanti
[survey-tool-elixir]: https://github.com/paulfioravanti/survey_tool_elixir
[travis-badge]: https://travis-ci.org/paulfioravanti/survey_tool_ruby.svg?branch=master
[travis-url]: https://travis-ci.org/paulfioravanti/survey_tool_ruby
[twitter-badge]: https://img.shields.io/badge/contact-%40paulfioravanti-blue.svg
[twitter-url]: https://twitter.com/paulfioravanti
[YARD]: https://github.com/lsegal/yard

---

# Requirements

# Culture Amp's Developer Coding Test

Your task is to build a CLI application to parse and display survey data from CSV files, and display the results.

## Data Format

### Survey Data
Included in the folder example-data are three sample data files defining surveys:
* survey-1.csv
* survey-2.csv
* survey-3.csv

Each row represents a question in that survey with headers defining what question data is in each column.

### Response Data
And three sample files containing responses to the corresponding survey:
* survey-1-responses.csv
* survey-2-responses.csv
* survey-3-responses.csv

Response columns are always in the following order:
* Email
* Employee Id
* Submitted At Timestamp (if there is no submitted at timestamp, you can assume the user did not submit a survey) 
* Each column from the fourth onwards are responses to survey questions.
* Answers to Rating Questions are always an integer between (and including) 1 and 5. 
* Blank answers represent not answered. 
* Answers to Single Select Questions can be any string.

## The Application

Your coding challenge is to build an application that allows the user to specify a survey file and a file for it's results. It should read them in and present a summary of the survey results. A command line application that takes a data file as input is sufficient.

The output should include: 

1. The participation percentage and total participant counts of the survey.
- Any response with a 'submitted_at' date has submitted and is said to have participated in the survey.
2. The average for each rating question
- Results from unsubmitted surveys should not be considered in the output. 

## Other information

Please include a Readme with any additional information you would like to include. You may wish to use it to explain any design decisions.

Despite this being a small command line app, please approach this as you would a production problem using whatever approach to coding and testing you feel appropriate. Successful candidates will be asked to extend their implementation in a pair programming session as a component of the interview, so consider extensibility.
