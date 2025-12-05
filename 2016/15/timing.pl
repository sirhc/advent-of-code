#!/usr/bin/env perl

use v5.40;
use strict;

# Disc #1 has 5 positions; at time=0, it is at position 4.
# Disc #2 has 2 positions; at time=0, it is at position 1.
my @discs = map { /Disc #\d+ has (\d+) positions; at time=\d+, it is at position (\d+)/ && [ $1, $2 ] } <>;
#         = ( [ <num_positions>, <current_position> ], ... )

my $time = 0;
my $pass;

while ( 1 ) {
  say sprintf 'time=%d', $time;

  $pass = 1;

  for ( my $d = 0; $d < @discs; ++$d ) {
    my $disc = $d + 1;
    my $pos  = ( $discs[$d]->[1] + $time + $disc ) % $discs[$d]->[0];

    say sprintf 'time=%d disc%d=%d', $time + $disc, $disc, $pos;

    $pass = $pass && $pos == 0;
  }

  last if $pass;

  $time++;
}
