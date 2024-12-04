#!/usr/bin/env perl

use v5.40;
use strict;

$|++;

my $password = $ARGV[0];
my $pattern  = join '|', map { $_ . chr(ord($_) + 1) . chr(ord($_) + 2) } 'a' .. 'x';  # abc|bcd|cde|...|xyz

# $num_problems = 2 * $num_regexes;

while ( 1 ) {
  ++$password;

  # Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz.
  # They cannot skip letters; abd doesn't count.
  next unless $password =~ /$pattern/;

  # Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are
  # therefore confusing.
  next if $password =~ /[iol]/;

  # Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
  next unless scalar @{[ $password =~ /(?:(.)\1)/g ]} >= 2;

  say $password;
}
