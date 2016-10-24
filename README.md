## What are your most common command line commands?

1.) Clone the repo and cd into it:

```git clone git@github.com:pszals/history_inspector.git && cd history_inspector```

2.) Create a `history.txt` file:

```touch history.txt && history > history.txt```

3.) Use IRB to check it out:

```irb```
```require './lib/inspector'```
```i = Inspector.new```
```i.top_ten```

You can also find an arbitrary number of top commands, i.e. `i.top(n)`3.) Use IRB to check it out:

```irb require './lib/inspector'\n i = Inspector.new\n i.top_ten```

