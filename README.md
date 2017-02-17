## What are your most common command line commands?

Clone the repo, cd into it, and run the Ruby program, passing the path to your histfile like so:

  `git clone git@github.com:pszals/history_inspector.git && cd history_inspector && bundle && ruby runner.rb $HISTFILE`

Prerequisites: Ruby 2.0+, Bundler


TODO:
Take input from the command line to:
  - [ ] Find top n commands
  - [ ] Handle other user requests (i.e. re-printing the graph)
  - [ ] Query against a time range to map by month

To run all the specs, execute `bundle exec rspec`. For continuously running the tests, use `bundle exec guard start`.
