#!/usr/bin/env perl

use v5.40;
use strict;

my $diagram = [ map { chomp; [ map { [ $_, 0 ] } split // ] } <> ];

for my $y ( 0 .. $#$diagram ) {
  for my $x ( 0 .. $#{ $diagram->[$y] } ) {
    next if $diagram->[$y][$x][0] eq '.';  # don't count neighbors for empty positions

    $diagram->[$y][$x][1] = count_neighbors( $diagram, $x, $y );
  }
}

render( $diagram );

sub count_neighbors {
  my ( $diagram, $x, $y ) = @_;  # x = column, y = row

  my $count = 0;

  for my $dy ( -1 .. 1 ) {
    for my $dx ( -1 .. 1 ) {
      my $nx = $x + $dx;
      my $ny = $y + $dy;

      next if $dx == 0 && $dy == 0;                    # self
      next if $nx < 0 || $nx > $#{ $diagram->[$ny] };  # out of bounds
      next if $ny < 0 || $ny > $#$diagram;             # out of bounds

      $count += 1 if $diagram->[$ny][$nx][0] eq '@';
    }
  }

  return $count;
}

sub render {
  my ( $diagram ) = @_;

  say join "\n", map { join '', map { $_->[0] eq '@' && $_->[1] < 4 ? 'x' : $_->[0] } @$_ } @$diagram;
}
