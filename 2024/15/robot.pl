#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

# ########
# #..O.O.#
# ##@.O..#
# #...O..#
# #.#.O..#
# #...O..#
# #......#
# ########
#
# <^^>>>vv<v>>v<<

my @map;
my @moves;
my $robot;  # [ $row, $col ]

my %dir = (
  '^' => [ -1,  0 ],  # up
  'v' => [  1,  0 ],  # down
  '<' => [  0, -1 ],  # left
  '>' => [  0,  1 ],  # right
);

while ( my $line = <> ) {
  chomp $line;
  last if $line eq '';
  push @map, [ split //, $line ];

  # Find the robot.
  my ( $col ) = grep { $map[$#map][$_] eq '@' } 0 .. $#{ $map[ $#map ] };
  $robot = [ $#map, $col ] if defined $col;
}

@moves = map { split // } split /\n/, do { local $/; <> };

# dd { map => \@map, moves => \@moves, robot => $robot };
print_map('Initial state:');

for my $move ( @moves ) {
  # dd { move => $move, robot => $robot };
  @$robot = move( @$robot, $move );
  # dd { move => $move, robot => $robot };

  # print_map("Move $move:");
}

print_map('Final state:');

my $sum = 0;

for my $row ( 0 .. $#map ) {
  for my $col ( 0 .. $#{ $map[$row] } ) {
    next unless $map[ $row ][ $col ] eq 'O';
    $sum += 100 * $row + $col;
  }
}

say $sum;

sub move {
  my ( $row, $col, $move ) = @_;

  # Get the next position of the token.
  my ( $nrow, $ncol ) = ( $row + $dir{ $move }[0], $col + $dir{ $move }[1] );

  if ( $map[ $nrow ][ $ncol ] eq 'O' ) {
    move( $nrow, $ncol, $move );
  }

  if ( $map[ $nrow ][ $ncol ] eq '#' ) {
    return ( $row, $col );
  }

  # If the next space is free, move there.
  if ( $map[ $nrow ][ $ncol ] eq '.' ) {
    $map[ $nrow ][ $ncol ] = $map[ $row ][ $col ];
    $map[ $row ][ $col ] = '.';
    return ( $nrow, $ncol );
  }

  return ( $row, $col );
}

sub print_map {
  say $_[0];
  say join '', @$_ for @map;
  say '';
}
