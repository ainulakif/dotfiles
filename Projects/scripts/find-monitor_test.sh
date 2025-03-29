
#!/bin/bash

RESOLUTION="$(xrandr | grep ' +' | awk '{ print $1 }')"

xrandr --output HDMI-1 --mode $RESOLUTION --above eDP-1 > /dev/null
