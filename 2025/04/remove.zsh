#!/usr/bin/env zsh

set -eu -o pipefail

input="${1?missing input file}"
input="$( cat $input )"

print $input
print

while true; do
  input="$( perl printing-department.pl <<< $input )"
  count="$( <<< $input grep -o . | sort | uniq -c | awk '$2 == "x" { print $1 }' )"
  count="${count:-0}"

  print $input
  print
  print "Removed: $count"
  print

  (( $count == 0 )) && break

  input="$( <<< $input sed -e 's/x/./g' )"
done
