#!/bin/bash

source "$(pwd)/spinner.sh"

check_units() {
  start_spinner 'Checking Failed Units...'
  readarray -t failed_units < <(systemctl --user --failed --no-legend | awk '{print $2}')

  # Display output based on content
  if [ ${#failed_units[@]} -eq 0 ]; then
    echo "No failed units found."
    count=0
    # echo "0"
  else
    # unit="${failed_units[0]}"
    count=${#failed_units[@]}
    # echo "${#failed_units[@]}" 
  fi
}

restart_units() {
  start_spinner "Restarting $1"
  result=0
}

local_spinner() {
  # start_spinner 'testing spinner...'
  sleep 0.5
  stop_spinner $1
}

check_units
local_spinner $count

if [ "$count" == 0 ]; then
  echo "No failed units found."
else

  for unit in "${failed_units[@]}"; do
    restart_units $unit
    local_spinner $result
  done

  echo "$count failed unit(s)"
fi

