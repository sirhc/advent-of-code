#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( pairs );

my @ranges = sort { $a->[0] <=> $b->[0] || $a->[1] <=> $b->[1] } map { chomp; [ split '-' ] } <>;

my $one = shift @ranges;
my $two;

while ( @ranges ) {
  $two = shift @ranges;

  # As we sorted the ranges by their left side, then by their right side, we know that the left side of $one is <= the left side of $two. If these are equal, we know
  # that the right side of $one is <= the right side of $two.

  if ( $two->[0] <= $one->[1] ) {
    # Ranges overlap or are contiguous, so merge them.
    $one->[1] = $one->[1] > $two->[1] ? $one->[1] : $two->[1];
  }
  else {
    # Ranges do not overlap.
    say sprintf '%s-%s', $one->[0], $one->[1];
    $one = $two;
  }
}

say sprintf '%s-%s', $one->[0], $one->[1];
