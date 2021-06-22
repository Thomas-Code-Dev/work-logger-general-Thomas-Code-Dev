#!/bin/bash

sum_work_hours() {
  count=0
  name=${1,}
  month=${2,}
  if [ -z "$month" ]; then
    ${month:=january}
  fi
  if [ -z "$name" ]; then
    ${name:=alice}
  fi
  file="logs/$name/$month.csv"
  if [ ! -f "${file}" ]; then
    echo "Error, the log for ${name^} regarding ${month^} does not exist" && exit 1
  fi
  while IFS=, read -r date day_of_week hours_worked; do
    [[ "$hours_worked" != "hours worked" ]] && ((count = count + $hours_worked))
  done <"$file"
  echo "${count}"
}

sum_work_hours $1 $2
