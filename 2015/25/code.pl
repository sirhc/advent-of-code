#!/usr/bin/env perl

use v5.40;
use strict;

use Math::BigInt lib => 'GMP';

my $first      = Math::BigInt->new('20151125');
my $multiplier = Math::BigInt->new('252533');
my $dividend   = Math::BigInt->new('33554393');

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
