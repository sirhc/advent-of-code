#!/usr/bin/env perl

use v5.40;
use strict;
use Math::Combinatorics qw( combine );

my @tiles = map { chomp; [ split /,/ ] } <>;

for my $pair ( combine( 2, @tiles ) ) {
  say sprintf '%d %d,%d %d,%d', area( @$pair ), @{ $pair->[0] }, @{ $pair->[1] };
}

sub area {
  my ( $a, $b ) = @_;

  my ( $x1, $y1 ) = @$a;
  my ( $x2, $y2 ) = @$b;

  my $w = ( abs $x1 - $x2 ) + 1;
  my $h = ( abs $y1 - $y2 ) + 1;

  return $w * $h;
}
