#!/usr/bin/env zsh

dial=50
pass=0

while read -r line; do
  case $line in
    L*)
      printf '%4d %-3s -> %4d\n' $dial $line $(( dial -= ${line#L} ))
      ;;
    R*)
      printf '%4d %-3s -> %4d\n' $dial $line $(( dial += ${line#R} ))
      ;;
  esac

  if (( dial % 100 == 0 )); then
    (( pass++ ))
  fi
done

printf '\nPassword: %d\n' $pass
