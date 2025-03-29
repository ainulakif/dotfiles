#!/bin/bash

# Check if the battery files exist and can be read
if [ ! -r /sys/class/power_supply/BAT0/capacity ] || [ ! -r /sys/class/power_supply/BAT0/status ]; then
  echo "Error: Unable to read battery files"
  exit 1
fi

# Read battery capacity and status
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

FLAG_FULL="/tmp/flag_battery_full"
FLAG_LOW="/tmp/flag_battery_low"

# Remove low battery flag if battery is charging or capacity is above 7%
if [ -f "$FLAG_LOW" ] && { [ "$CAPACITY" -ge 7 ] || [ "$STATUS" = "Charging" ]; }; then
  rm "$FLAG_LOW"
fi

# Check for low battery
if [ "$CAPACITY" -lt 20 ] && [ "$STATUS" = "Discharging" ]; then
  notify-send -u critical "BATTERY LOW" --app-name="Alert"
# Check for full battery
elif [ "$CAPACITY" -ge 90 ] && [ "$STATUS" = "Charging" ] && [ ! -f "$FLAG_FULL" ]; then
  touch "$FLAG_FULL"
  notify-send -u low "BATTERY FULL" --app-name="Info"
# Check for critical battery
elif [ "$CAPACITY" -lt 7 ] && [ "$STATUS" = "Discharging" ] && [ ! -f "$FLAG_LOW" ]; then
  touch "$FLAG_LOW"
  notify-send -u critical "BATTERY CRITICAL ($CAPACITY%): Suspending system in 2 minutes" --app-name="Alert"
  ( sleep 120; if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -lt 7 ]; then systemctl suspend; fi ) &
  while true; do
    CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$STATUS" = "Charging" ] || [ "$CAPACITY" -ge 7 ]; then
      pkill -f "sleep 120"
      break
    fi
    sleep 1
  done
fi

# Remove full battery flag if battery is not full
if [ "$CAPACITY" -lt 90 ] && [ "$STATUS" = "Charging" ] && [ -f "$FLAG_FULL" ]; then
  rm "$FLAG_FULL"
fi
