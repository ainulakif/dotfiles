#!/bin/bash

source "$(pwd)/spinner.sh"

check_units() {
  start_spinner 'Checking Failed Units...'
  readarray -t failed_units < <(systemctl --user --failed --no-legend | awk '{print $2}')

  # Display output based on content
  if [ ${#failed_units[@]} -eq 0 ]; then
    # echo "No failed units found."
    count=0
    # echo "0"
  else
    # unit="${failed_units[0]}"
    count=${#failed_units[@]}
    # echo "${#failed_units[@]}" 
  fi
}

restart_units() {
  unit_name="$1"
  add_fail=0


  systemctl --user restart "$unit_name"
  # if [ $? -ne 0 ]; then
  #   echo "Failed to restart $unit_name"
  #   add_fail=1
  # else
  #   echo "Restarting $unit_name"
  # fi
}

local_spinner() {
  sleep 0.5
  stop_spinner $1
}

check_units
local_spinner $count

if [ "$count" == 0 ]; then
  echo "    No failed units found."
else


  echo "    $count failed unit(s)"

  failed_count=0
  for unit in "${failed_units[@]}"; do
    start_spinner "Restarting $unit"
    restart_units $unit

    local_spinner $failed_count
    # if [ $add_fail == 1 ]; then
    #   ((failed_count++)) 
    # fi
  done
fi

