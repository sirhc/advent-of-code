#!/usr/bin/env awk

# Skip odd-length numbers.
( length($1) % 2 == 1 ) { next }

# 123123 -> 123 123
{ $0 = substr($0, 1, length / 2) FS substr($0, length / 2 + 1) }

( $1 == $2 ) {
  print ">", $1, $2
  sum += $1$2
}

END { print "Sum:", sum }
