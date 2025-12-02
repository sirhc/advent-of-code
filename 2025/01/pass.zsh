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

  printf '%-4s -> %2d (%4d)\n' S $dial $pass

  while read -r line; do
    init=$dial
    last=$pass

    case $line in
      L*)
        if (( ${line#L} >= 100 )); then
          pass=$(( pass + ${line#L} / 100 - 1 - (init == 0 ? 1 : 0) ))  # for every 100 clicks, we're guaranteed to pass zero (starting on zero means one fewer passes)
        fi
        dial=$(( dial - ${line#L} ))
        ;;
      R*)
        if (( ${line#R} >= 100 )); then
          pass=$(( pass + ${line#R} / 100 - 1 - (init == 0 ? 1 : 0) ))
        fi
        dial=$(( dial + ${line#R} ))
        ;;
    esac

    # If we've gone negative, we passed zero, unless we started at zero. Multiple revolutions are handled above.
    if (( dial < 0 && init != 0 )); then
      pass=$(( pass + 1 ))
    fi

    # If we've gone past 99, we passed zero. Unless our landing position is on zero, which we count later.
    if (( dial > 99 && dial % 100 != 0 )); then
      pass=$(( pass + 1 ))
    fi

    # Set the dial to the real position (e.g., -10 is actually 90).
    dial=$(( ( dial % 100 + 100 ) % 100 ))

    # We also need to count when we've landed on zero.
    if (( dial == 0 )); then
      pass=$(( pass + 1 ))
    fi

    if (( last != pass )); then
      printf '%2d + %-4s -> %2d (%4d)\n' $init $line $dial $pass
    fi
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
    part_two_loop
    ;;
esac
