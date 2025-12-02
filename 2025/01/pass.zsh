#!/usr/bin/env zsh

set -eu -o pipefail

part_one() {
  local dial=50
  local pass=0
  local line

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
      pass=$(( pass + 1 ))
    fi
  done

  printf '\nPassword for Part One: %d\n' $pass
}

part_two() {
  local dial=50
  local pass=0
  local line
  local init

  while read -r line; do
    init=$dial
    dist=${line:1}
    pass=$(( pass + dist / 100 ))  # for every 100 clicks, we're guaranteed to pass zero (note, we may start or land on zero)

    # If we turn the dial by a multiple of 100, we haven't changed position. Starting and landing on zero is accounted for above.
    if (( dist % 100 != 0 )); then
      case ${line:0:1} in
        R) dist=$(( ( dist % 100 ) )) ;;
        L) dist=$(( ( dist % 100 ) * -1 )) ;;
      esac

      # Adjust the dial by the final offset.
      dial=$(( dial + dist ))

      if (( init != 0 && (dial <= 0 || dial > 99) )); then
        pass=$(( pass + 1 ))
      fi

      dial=$(( ( dial % 100 + 100 ) % 100 ))
    fi

    printf '%2d + %-4s -> %2d (%4d)\n' $init $line $dial $pass
  done

  printf '\nPassword for Part Two: %d\n' $pass
}

part_two_loop() {
  local dial=50 init
  local pass=0
  local line direction clicks click

  while read -r line; do
    init=$dial
    direction=${line:0:1}
    clicks=${line:1}

    case $direction in
      L ) direction=-1 ;;
      R ) direction=1  ;;
    esac

    for (( click = 0; click < clicks; click++ )); do
      dial=$(( ( ( dial + direction ) % 100 + 100 ) % 100 ))
      pass=$(( pass + ( dial == 0 ? 1 : 0 ) ))
    done

    printf '%2d + %-4s -> %2d (%4d)\n' $init $line $dial $pass
  done

  printf '\nPassword for Part Two: %d\n' $pass
}

case "${1-one}" in
  1 | one | part1 | part_one )
    part_one
    ;;
  2 | two | part2 | part_two )
    part_two
    ;;
esac
