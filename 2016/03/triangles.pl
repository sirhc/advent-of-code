#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @part1 = map { [ split ] } <>;
# dd \@part1;

do { say "Part 1: Triangle with sides @{[ join ', ', @$_ ]} is valid." if is_valid( @$_ ) } for @part1;

# Part 2: Transpose the input triangles by reading down each column of the original input, grouping by threes.

my @part2 = ();

for my $x ( 0 .. 2 ) {
  for my $y ( 0 .. $#part1 / 3 ) {
    push @part2, [
      $part1[ $y * 3     ][$x],
      $part1[ $y * 3 + 1 ][$x],
      $part1[ $y * 3 + 2 ][$x],
    ];
  }
}
# dd \@part2;

do { say "Part 2: Triangle with sides @{[ join ', ', @$_ ]} is valid." if is_valid( @$_ ) } for @part2;

sub is_valid {
  my ( $a, $b, $c ) = @_;

  return if $a + $b <= $c;
  return if $a + $c <= $b;
  return if $b + $c <= $a;
  return 1;
}
