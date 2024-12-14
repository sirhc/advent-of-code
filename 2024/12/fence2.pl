#!/usr/bin/env perl

use v5.40;
use strict;
no warnings 'recursion';

use List::Util qw( sum uniqstr );
use Data::Dump;

my @plots;    # $plots[ $row ][ $col ] = [ $plant, $visited ]
my @regions;  # $regions[ $i ]         = [ [ $row, $col ], ... ]

my @dirs = (
  [ -1,  0 ],  # up
  [  1,  0 ],  # down
  [  0, -1 ],  # left
  [  0,  1 ],  # right
);

# . . O . .
# . +---+ .
# O | X | O
# . +---+ .
# . . O . .

my @corners = (
  [ [ -1, 0 ], [ -1, -1 ], [ 0, -1 ], [ 0, 0 ] ],  # upper left
  [ [ -1, 0 ], [ -1,  1 ], [ 0,  1 ], [ 0, 1 ] ],  # upper right
  [ [  1, 0 ], [  1, -1 ], [ 0, -1 ], [ 1, 0 ] ],  # lower left
  [ [  1, 0 ], [  1,  1 ], [ 0,  1 ], [ 1, 1 ] ],  # lower right
  #            ^^^^^^^^^^             ^^^^^^^^
  #            diagonal               vertex
);

while ( my $line = <> ) {
  chomp $line;
  push @plots, [ map { [ $_, '' ] } split //, $line ];
}

# dd \@plots;

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

# dd \@plots;
# dd \@regions;

sub calculate_area {
  my ( $region ) = @_;

  # The area is simply the number of plots in the region.
  return scalar @$region;
}

# True if the given plot is part of the region.
sub in_region {
  my ( $region, $row, $col ) = @_;
  # dd [ 'in_region', [ $row, $col ], $region ];

  return +( grep { $_->[0] == $row && $_->[1] == $col } @$region ) ? 1 : 0;
}

# If the plot we're looking at is the bottom right, these are the possible arrangements.
#
# .   .
#   + -
# . | 0
#
# .   .    1 | .    . | 1
# - - -    - + -      |
# 1   1    . | 1    . | 1
#          ^^^^^
#          this one needs to be counted twice
#
# 2 | .    . | 2    2   2
#   + -    - +      - +  
# 2   2    2   2    . | 2
#
# 3   3
#
# 3   3

sub corner_case {
  my ( $side1, $diagonal, $side2 ) = @_;

  return 1 if $side1 == 0 && $diagonal == 0 && $side2 == 0;  # 0 case
  return 2 if $side1 == 0 && $diagonal == 1 && $side2 == 0;  # <--- this is the one that needs to be counted twice
  return 3 if $side1 == 1 && $diagonal == 1 && $side2 == 0;  # 2 cases
  return 4 if $side1 == 1 && $diagonal == 0 && $side2 == 1;
  return 5 if $side1 == 0 && $diagonal == 1 && $side2 == 1;
  return '';
}

sub calculate_side {
  my ( $region ) = @_;

  my @vertices;
  my $plant = $plots[ $region->[0][0] ][ $region->[0][1] ][0];
  my $sum   = 0;

  # dd [ 'calculate_side', $plant, $region ];

  for my $plot ( @$region ) {
    my ( $row, $col ) = @$plot;

    push @vertices,
      map {
        # If this is a corner case (heh), mark it with the plot we're looking at it from. This way, our vertex count
        # still works.
        "($_->[3][0], $_->[3][1])" . ( $_->[4] == 2 ? " ($row, $col)" : '' )
      }
      grep {
        $_->[4]
      }
      map {
        push @$_, corner_case( @$_ );
        $_;
      }
      map {
        [
          in_region( $region, @{ $_->[0] } ),
          in_region( $region, @{ $_->[1] } ),
          in_region( $region, @{ $_->[2] } ),
          $_->[3],
        ]
      }
      map {
        [
          [ $row + $_->[0][0], $col + $_->[0][1] ],  # side 1
          [ $row + $_->[1][0], $col + $_->[1][1] ],  # diagonal
          [ $row + $_->[2][0], $col + $_->[2][1] ],  # side 2
          [ $row + $_->[3][0], $col + $_->[3][1] ],  # vertex
        ]
      }
      @corners;
  }

  # dd [ @vertices ];
  # dd [ uniqstr @vertices ];

  return uniqstr @vertices;
}

say join "\n", map { join '', @$_ } map { [ map { $_->[0] } @$_ ] } @plots;
# say join "\n\n", map { join '  ', @$_ } map { [ map { $_->[0] } @$_ ] } @plots;

my $total = 0;

for my $region ( @regions ) {
  my $plant = $plots[ $region->[0][0] ][ $region->[0][1] ][0];
  my $area = calculate_area( $region );
  my $peri = calculate_side( $region );

  say sprintf '- A region of %s plants with price %d * %d = %d.', $plant, $area, $peri, $area * $peri;

  $total += $area * $peri;
}

say '';
say $total;
