#!/usr/bin/env zsh

set -eu -o pipefail

print -n 'Part 1 -> '
paste -d- <( awk '{ print $1 }' input | sort -n ) <( awk '{ print $2 }' input | sort -n ) | bc | sed -e 's/^-//' | paste -sd+ | bc

print -n 'Part 2 -> '
parallel -C ' +' 'echo -n "{1}*"; grep -Fc " {1}" input' < input | bc | paste -sd+ | bc
