#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( sum );
use Math::Prime::Util qw( divisors );  # like I have time to come up with my own efficient factoring algorithm
use Data::Dump;

my $input = shift @ARGV // 9;

# dd divisors($input);

for my $house ( 1 .. $input ) {
  my $presents = sum map { 10 * $_ } divisors($house);

  if ( $presents >= $input ) {
    say sprintf 'House %d got %d presents.', $house, $presents;
    last;
  }
}
