#!/bin/bash

sum_working_hours() {
  count=0
  while IFS=, read -r date day_of_week hours_worked; do
    [[ "$hours_worked" != "hours worked" ]] && ((count = count + $hours_worked))
  done < logs/bob/january.csv
  echo "${count}"
}

sum_working_hours