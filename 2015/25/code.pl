#!/usr/bin/env perl

use v5.40;
use strict;

use Math::BigInt lib => 'GMP';

my $first      = 20151125;
my $multiplier = 252533;
my $dividend   = 33554393;

# Example.
# for my $row ( 1 .. 6 ) {
#   for my $col ( 1 .. 6 ) {
#     say sprintf '(%d, %d) => %d', $row, $col, compute_code( $row, $col );
#   }
# }

# Input.
my ( $row, $col ) = map { /row (\d+), column (\d+)/ } <>;
say sprintf '(%d, %d) => %d', $row, $col, compute_code( $row, $col );

sub compute_code {
  my ( $row, $col ) = @_;
  my $exp = ($row + $col - 2) * ($row + $col - 1) / 2 + $col - 1;
  return ((($multiplier ** $exp) % $dividend) * $first) % $dividend;
}
