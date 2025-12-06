#!/usr/bin/env perl

use v5.40;
use strict;

my @numbers = ( 1 .. 20 );

say '   ', join ' ', map { sprintf '%2d', $_ } @numbers;

for my $row ( @numbers ) {
  print sprintf '%2d ', $row;
  print sprintf '%2d ', josephus_number($_) for 1 .. $row;
  print "\n";
}

sub josephus_number {
  my ( $n ) = @_;
  return 2 * ($n - (1 << (int(log($n)/log(2))))) + 1;
}
