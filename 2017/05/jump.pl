#!/usr/bin/env perl

use v5.40;
use strict;

my @input = map { chomp; $_ } <>;
my $pointer = 0;
my $steps = 0;

while ( $pointer >= 0 && $pointer < @input ) {
  my $jump = $input[$pointer]++;
  $steps += 1;
  $pointer += $jump;
}

say $steps;
