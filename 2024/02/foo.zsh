#!/usr/bin/env zsh

# set -eu -o pipefail

# Part One

while read -r line; do
  diff -s <( tr ' ' '\n' <<< $line ) <( tr ' ' '\n' <<< $line | sort -n )  >& /dev/null; a=$?
  diff -s <( tr ' ' '\n' <<< $line ) <( tr ' ' '\n' <<< $line | sort -nr ) >& /dev/null; b=$?

  if [[ $a -gt 0 && $b -gt 0 ]]; then
    print "Part 1 -> Unsafe $line"
    continue
  fi

  levels=($( tr ' ' '\n' <<< $line | sort -nr ))

  for i in {1..$(( $#levels - 1 ))}; do
    d=$(( $levels[$i] - $levels[$(( i + 1 ))] ))

    if [[ $d -lt 1 || $d -gt 3 ]]; then
      print "Part 1 -> Unsafe $line"
      continue 2
    fi
  done

  print "Part 1 -> Safe $line"
done
