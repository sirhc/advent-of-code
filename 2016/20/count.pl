#!/usr/bin/env perl

use v5.40;
use strict;

my $max    = shift // 2 ** 32 - 1;
my @ranges = map { chomp; [ split '-' ] } <>;
my $count  = 0;

my $one   = shift @ranges;
my $two;

while ( @ranges ) {
  $two = shift @ranges;
  $count += $two->[0] - $one->[1] - 1;  # e.g., gap between 0-2 and 4-8 is 1 (3)
  $one = $two;
}

say $count + ( $max - $one->[1] );
