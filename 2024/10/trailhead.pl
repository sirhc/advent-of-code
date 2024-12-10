#!/usr/bin/env perl

use v5.40;
use strict;

use Term::ANSIColor;
use List::Util qw( sum );
use Data::Dump;

my @map;  # $map[$row][$col] = [ $elevation, $visited ]
my @directions = (
  [ -1,  0 ],  # up
  [  1,  0 ],  # down
  [  0,  1 ],  # right
  [  0, -1 ],  # left
);

while ( my $line = <> ) {
  chomp $line;

  push @map, [ map { [ $_, 0 ] } split //, $line ];
}

sub print_map {
  say for map { join '', map { $_->[1] ? colored($_->[0], 'bold red') : $_->[0] } @$_ } @map;
  say '';
}

sub initialize {
  for my $row ( 0 .. $#map ) {
    for my $col ( 0 .. $#{ $map[$row] } ) {
      $map[$row][$col][1] = 0;
    }
  }
}

sub explore {
  my ( $row, $col ) = @_;

  # dd { row => $row, col => $col, location => $map[$row][$col] };

  # If this location has been visited, we don't need to explore it again.
  return if $map[$row][$col][1];

  # Mark this location as visited.
  $map[$row][$col][1] = 1;

  # If we've reached a 9, we don't need to explore further.
  return if $map[$row][$col][0] eq '9';

  map { explore(@$_) }                                                                               # try the next location
    grep { $map[ $_->[0] ][ $_->[1] ][0] - $map[$row][$col][0] == 1 }                                # only look at locations with an elevation 1 higher
    grep { $map[ $_->[0] ][ $_->[1] ][0] ne '.' }                                                    # to suppress warnings from the example input
    grep { $_->[0] >= 0 && $_->[0] <= $#map && $_->[1] >= 0 && $_->[1] <= $#{ $map[ $_->[0] ] } }    # ensure it's on the map
    map  { [ $row + $_->[0], $col + $_->[1] ] }                                                      # convert directions into next potential location
    @directions
}

# dd @map;
# print_map();

my @trailheads;

for my $row ( 0 .. $#map ) {
  for my $col ( 0 .. $#{ $map[$row] } ) {
    next if $map[$row][$col][0] ne '0';

    initialize();    # reset the map for this trailhead
    explore( $row, $col );

    # dd @map;
    # print_map();

    # How many summits did we encounter on this trailhead?
    push @trailheads, sum map { 1 } grep { $_->[0] eq '9' && $_->[1] > 0 } map { @$_ } @map;
  }
}

say sum @trailheads;
