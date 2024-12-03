#!/usr/bin/env perl

use v5.34;
use strict;

while ( my $line = <> ) {
  chomp $line;

  # It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy)
  # or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
  next unless $line =~ /(..).*\1/;

  # It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or
  # even aaa.
  next unless $line =~ /(.).\1/;

  say $line;
}
