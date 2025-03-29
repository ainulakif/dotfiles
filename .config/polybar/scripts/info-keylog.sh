#!/usr/bin/env bash


# Get the keyboard device ID (adjust the grep pattern if needed)
# KEYBOARD_ID=$(xinput list --short | grep "AT Translated Set 2 keyboard" | awk -F'id=' '{print $2}' | awk '{print $1}')

KEYBOARD_ID=$(xinput list --short | grep -E 'Compx 2.4G Wireless Receiver[[:space:]]+id=' | awk -F'id=' '{print $2}' | awk '{print $1}')

# Temporary file for Polybar display
TMP_FILE="/tmp/keystrokes.txt"

# Build a keymap using xmodmap output.
# This associative array maps keycodes to a single representative key name.
declare -A keymap

while read -r line; do
    # Example line: "keycode   9 = Escape NoSymbol Escape"
    if [[ $line =~ ^keycode[[:space:]]+([0-9]+)[[:space:]]*=[[:space:]]+(.*) ]]; then
        keycode="${BASH_REMATCH[1]}"
        # Remove 'NoSymbol' and trim extra whitespace
        symbols=$(echo "${BASH_REMATCH[2]}" | sed 's/NoSymbol//g' | xargs)
        # For simplicity, take the first symbol (you can expand this to handle modifiers)
        keyname=$(echo "$symbols" | awk '{print $1}')
        keymap["$keycode"]="$keyname"
    fi
done < <(xmodmap -pke)

# Initialize the output file
> "$TMP_FILE"

# Listen for key events using xinput test.
# When a key press event occurs, look up its key name and write it to TMP_FILE.
xinput test "$KEYBOARD_ID" | while read -r line; do
    if [[ $line =~ key\ press[[:space:]]+([0-9]+) ]]; then
        keycode="${BASH_REMATCH[1]}"
        # Lookup the key name; default to the code if not found.
        key="${keymap[$keycode]:-$keycode}"
        # Write the key pressed to the temporary file (overwrite each time).
        echo "$key" > "$TMP_FILE"
    fi
done

