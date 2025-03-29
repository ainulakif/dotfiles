
#!/bin/bash

declare -rx STEPS=(
  'Checking Failed Units'
  'install'
  'post-install'
)

declare -rx CMDS=(
  check_units
  # 'sleep 1'
  # 'sleep 1'
)

start_spinner() {
    # Start the spinner display for each command in the CMDS array.
  local step=0

  # Hide the cursor for a cleaner spinner display.
  tput civis

  while [ "$step" -lt "${#CMDS[@]}" ]; do
    # Execute the command in the background and capture its PID.
    # eval "${CMDS[$step]}" & pid=$!
    # count=$("${CMDS[$step]}") & pid=$!
    "${CMDS[$step]}" > /tmp/count_output & pid=$!

    # While the command is running, show the spinner.
    while ps -p $pid &>/dev/null; do
      echo -ne "\\r[   ] ${STEPS[$step]} ..."
      for k in "${!FRAME[@]}"; do
        echo -ne "\\r[ ${FRAME[k]} ]"
        sleep $FRAME_INTERVAL
      done
    done

    # Only call start() on the first step.
    # if [ "$step" -eq 0 ]; then
    #   # Once the command completes, show a success message.
    #   echo -ne "\\r[ ✔ ] ${STEPS[$step]}: $count Failed Units\\n"
    # elif [ "$count" -gt 0 -a "$step" -eq 1 ]; then
    #   echo -ne "\\r[ ✔ ] ${STEPS[$step]}: Restarted\\n"
    # elif [ "$count" -gt 0 -a "$step" -eq 2 ]; then
    #   echo -ne "\\r[ ✔ ] ${STEPS[$step]}: Complete\\n"
    # else
    #   # Once the command completes, show a success message.
    #   echo -ne "\\r[ ✔ ] ${STEPS[$step]} \\n"
    # fi
    
    count=$(cat /tmp/count_output)  # Read the output after process completes
    echo "Final count: $count"
    # Only call start() on the first step.
    if [ "$step" -eq 0 ]; then
      # check_units
      # Once the command completes, show a success message.
      echo -ne "\\r[ ✔ ] ${STEPS[$step]}: $count Failed Units\\n"
    else
      # Once the command completes, show a success message.
      echo -ne "\\r[ ✔ ] ${STEPS[$step]} \\n"
    fi

    step=$((step + 1))
  done

  # Restore the cursor.
  tput cnorm
}

set_spinner() {
  FRAME=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  FRAME_INTERVAL=0.1
}

check_units() {
  readarray -t failed_units < <(systemctl --user --failed --no-legend | awk '{print $2}')

  # echo $failed_units

  # systemctl --failed --no-legend | awk '{print $2}'


  # Display output based on content
 if [ ${#failed_units[@]} -eq 0 ]; then
    echo "No failed units found."
  else
    count=${#failed_units[@]}
  fi


  # Create a transient unit that immediately fails
  # systemd-run --user --unit=dummyfail1.service /bin/false
  # systemd-run --user --unit=dummyfail2.service /bin/false

  # systemctl --user reset-failed dummyfail1.service dummyfail2.service
}

set_spinner
start_spinner

