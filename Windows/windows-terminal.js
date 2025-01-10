// This is a windows terminal profile for opening a 2x2 grid at a specified directory. It's a bit messy but it works.
var profile = {
    "commandline": "wt -w 0 new-tab --startingDirectory \"C:\\SomeDirectory\" -p \"Foo\" ; split-pane -V -p \"Bar\"  --startingDirectory \"C:\\SomeDirectory\"  ; move-focus left ; split-pane  --startingDirectory \"C:\\SomeDirectory\" -H -p \"Baz\" ; move-focus up ; move-focus right ; split-pane  --startingDirectory \"C:\\SomeDirectory\" -H -p \"Git Bash\"",
    "hidden": false,
    "name": "DrawingGame"
}