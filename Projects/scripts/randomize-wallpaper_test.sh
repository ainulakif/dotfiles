
#!/bin/bash

# Directory where wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/wallpaper"
CHILD="/rest"

# Send a notification
if [ "$1" == "work" ]; then

  TARGET=$WALLPAPER_DIR

  # Get a random image from the directory
elif [ "$1" == "break" ]; then
  TARGET=$WALLPAPER_DIR$CHILD
fi

echo WALLPAPER=$(find "$TARGET" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
