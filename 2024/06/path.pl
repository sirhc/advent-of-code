#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Printer;
use List::Util qw( sum );

my @map;
my @guard;  # ( row, col, orientation )

# We could obviously do away with updating the graphical representation and just count, but it's more fun this way.

my @movements = (
  [ -1,  0, '^' ],  # up    -> row - 1
  [  0,  1, '>' ],  # right -> col + 1
  [  1,  0, 'v' ],  # down  -> row + 1
  [  0, -1, '<' ],  # left  -> col - 1
);

while ( my $line = <> ) {
  chomp $line;

  push @map, [ split //, $line ];

  my ( $col ) = grep { $map[-1][$_] eq '^' } 0 .. $#{$map[-1]};
  push @guard, ( $#map, $col, 0 ) if $col;
}

my $rows = @map;
my $cols = @{ $map[0] };
my @next;

# p @guard;
# p $rows;
# p $cols;

while ( 1 ) {
  # Mark the guard's current (soon to be previous) position.
  $map[ $guard[0] ][ $guard[1] ] = 'X';

  # Get the guard's next space.
  my @next = ( $guard[0] + $movements[ $guard[2] ][0], $guard[1] + $movements[ $guard[2] ][1] );

  # If the guard has left the map, we're done.
  last if $next[0] < 0 || $next[0] >= $rows || $next[1] < 0 || $next[1] >= $cols;

  # If the guard is blocked, turn them to the right and try again.
  if ( $map[ $next[0] ][ $next[1] ] eq '#' ) {
    $guard[2] = ($guard[2] + 1) % @movements;
    next;
  }

  # Move the guard.
  @guard[ 0, 1 ] = @next;

  # Mark the guard's new position.
  $map[ $guard[0] ][ $guard[1] ] = $movements[ $guard[2] ][2];
}

# Print the final map, because it looks cool.
say join '', @$_ for @map;

# Finally, count the number of spaces visited.
say '';
say sum map { map { $_ eq 'X' ? 1 : 0 } @$_ } @map;
