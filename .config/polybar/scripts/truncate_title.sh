
#!/bin/bash

# Get the active window title (this example assumes an X environment)
title=$(xprop -id "$(xdotool getactivewindow)" WM_NAME | cut -d '"' -f2)
# Trim the title at the first "-" (everything after "-" is removed)
trimmed_title=${title%%-*}
echo "$trimmed_title"
