#!/bin/bash

sum_working_hours() {
  count=0
  month=$1
  if [ -z "$month" ]; then
    ${month:=january}
  fi
  file="logs/bob/$month.csv"
  if [ ! -f "${file}" ]; then
    echo "Error, the log for ${month^} does not exist" && exit 1
  fi
  while IFS=, read -r date day_of_week hours_worked; do
    [[ "$hours_worked" != "hours worked" ]] && ((count = count + $hours_worked))
  done <"$file"

  echo "${count}"
}

sum_working_hours "$1"
