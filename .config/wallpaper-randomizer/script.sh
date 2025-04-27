
#!/bin/bash

# Check if i3lock is running
if pgrep -x "i3lock" > /dev/null; then
    echo "Screen is locked, skipping execution."
    exit 1
fi

# Directory where wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CHILD="/rest"

# Send a notification
if [ "$1" == "work" ]; then
  notify-send "Started 🍅" --app-name="Timer"
  TARGET=$WALLPAPER_DIR
elif [ "$1" == "break" ]; then
  notify-send "Break Time ☕" --app-name="Timer"
  # TARGET=$WALLPAPER_DIR$CHILD
  TARGET=$WALLPAPER_DIR
fi

WALLPAPER=$(find "$TARGET" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)

# Set the wallpaper using feh
feh --no-fehbg --bg-fill "$WALLPAPER"

