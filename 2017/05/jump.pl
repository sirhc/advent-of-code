#!/usr/bin/env perl

use v5.40;
use strict;

my $part = shift // 1;
my @input = map { chomp; $_ } <>;
my $pointer = 0;
my $steps = 0;

while ( $pointer >= 0 && $pointer < @input ) {
  my $jump = $input[$pointer];
  $input[$pointer] += ( $part == 1 ) ? 1 : ( $jump >= 3 ) ? -1 : 1;
  $steps += 1;
  $pointer += $jump;
}

say $steps;
