#!/usr/bin/env perl

use v5.34;
use strict;

while ( my $line = <> ) {
  chomp $line;

  # It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
  next unless scalar @{[ $line =~ /([aeiou])/g ]} >= 3;

  # It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
  next unless $line =~ /(.)\1/;

  # It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
  next if $line =~ /(?:ab|cd|pq|xy)/;

  say $line;
}
