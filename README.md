## What are your most common command line commands?

1.) Clone the repo, cd into it, and create a `history.txt` file:

  `git clone git@github.com:pszals/history_inspector.git && cd history_inspector && touch history.txt && history > history.txt`

2.) Use Ruby to get your top ten most-used commands:

  `ruby runner.rb`

TODO:
Take input from the command line to:
  - [ ] Find top n commands
  - [ ] Handle other user requests (i.e. re-printing the graph)
