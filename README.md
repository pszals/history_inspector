## What are your most common command line commands?

Clone the repo, cd into it, and run the Ruby program, passing the path to your histfile like so:

  `git clone git@github.com:pszals/history_inspector.git && cd history_inspector && ruby runner.rb $HISTFILE`


TODO:
Take input from the command line to:
  - [ ] Find top n commands
  - [ ] Handle other user requests (i.e. re-printing the graph)

To run all the specs, execute `bundle exec rspec`. For continuously running the tests, use `bundle exec guard start`.
