#!/usr/bin/env perl

use v5.40;
use strict;
no warnings 'recursion';

use List::Util qw( sum );
use Data::Dump;

my @plots;    # $plots[ $row ][ $col ] = [ $plant, $visited ]
my @regions;  # $regions[ $i ]         = [ [ $row, $col ], ... ]

my @dirs = (
  [ -1,  0 ],  # up
  [  1,  0 ],  # down
  [  0, -1 ],  # left
  [  0,  1 ],  # right
);

while ( my $line = <> ) {
  chomp $line;
  push @plots, [ map { [ $_, '' ] } split //, $line ];
}

# dd \@plots;
# dd \@dirs;

sub visited {
  my ( $row, $col ) = @_;
  return $plots[ $row ][ $col ][1];
}

sub mark_visited {
  my ( $row, $col ) = @_;
  $plots[ $row ][ $col ][1] = 1;
  return [ $row, $col ];
}

sub visit_region {
  my ( $row, $col, $region ) = @_;

  # dd [ $row, $col, $plots[$row][$col] ];

  # Have we already visited this plot?
  return if visited( $row, $col );

  # Are we in a new region?
  if ( ! defined $region ) {
    $region = [];
    push @regions, $region;
  }

  # Add the current plot to the region and mark it as visited.
  push @$region, mark_visited( $row, $col );

  # Look around to see if we can expand our region.
  for my $dir ( @dirs ) {
    my ( $drow, $dcol ) = ( $row + $dir->[0], $col + $dir->[1] );

    # Out of bounds?
    next if $drow < 0 || $drow > $#plots;
    next if $dcol < 0 || $dcol > $#{ $plots[$drow] };

    # Different plant?
    next if $plots[$drow][$dcol][0] ne $plots[$row][$col][0];

    # Visit the neighboring plot.
    visit_region( $drow, $dcol, $region );
  }
}

for my $row ( 0 .. $#plots ) {
  for my $col ( 0 .. $#{ $plots[$row] } ) {
    visit_region( $row, $col );
  }
}

# dd \@regions;

sub calculate_area {
  my ( $region ) = @_;

  # The area is simply the number of plots in the region.
  return scalar @$region;
}

sub calculate_peri {
  my ( $region ) = @_;

  my $plant = $plots[ $region->[0][0] ][ $region->[0][1] ][0];
  my $sum   = 0;

  # The perimeter is the sum of the edges that have a different plot on the other side (or are on a boundary).
  for my $plot ( @$region ) {
    my ( $row, $col ) = @$plot;

    $sum += (
      sum map { 1 }
        grep {
          $_->[0] < 0 || $_->[0] > $#plots ||                  # neighbor row is out of bounds
          $_->[1] < 0 || $_->[1] > $#{ $plots[ $_->[0] ] } ||  # neighbor col is out of bounds
          $plots[ $_->[0] ][ $_->[1] ][0] ne $plant            # neighboring plant is different
        }
        map { [ $row + $_->[0], $col + $_->[1] ] }  # translate each direction to the neighboring plot
        @dirs
    ) // 0;
  }

  return $sum;
}

my $total = 0;

for my $region ( @regions ) {
  my $plant = $plots[ $region->[0][0] ][ $region->[0][1] ][0];
  my $area = calculate_area( $region );
  my $peri = calculate_peri( $region );

  say sprintf '- A region of %s plants with price %d * %d = %d.', $plant, $area, $peri, $area * $peri;

  $total += $area * $peri;
}

say '';
say $total;
