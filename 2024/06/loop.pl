#!/usr/bin/env perl

use v5.40;
use strict;

my @map;
my @guard    = ( shift @ARGV, shift @ARGV, 0 );  # ( row, col, orientation )
my @obstacle = ( shift @ARGV, shift @ARGV );

# We could obviously do away with updating the graphical representation and just count, but it's more fun this way.

my @movements = (
  [ -1,  0, '^', '↑' ],  # up    -> row - 1
  [  0,  1, '>', '→' ],  # right -> col + 1
  [  1,  0, 'v', '↓' ],  # down  -> row + 1
  [  0, -1, '<', '←' ],  # left  -> col - 1
);

while ( my $line = <> ) {
  chomp $line;
  push @map, [ split //, $line ];
}

my $rows = @map;
my $cols = @{ $map[0] };
my @next;

# Attempt to place the obstacle.
if ( $obstacle[0] == $guard[0] && $obstacle[1] == $guard[1] ) {
  say 'Attempt to place obstacle on guard';
  exit;
}

if ( $map[ $obstacle[0] ][ $obstacle[1] ] eq '#' ) {
  say 'Attempt to place obstacle on obstacle';
  exit;
}

if ( $map[ $obstacle[0] ][ $obstacle[1] ] eq '.' ) {
  say 'Attempt to place obstacle in pointless location';
  exit;
}

$map[ $obstacle[0] ][ $obstacle[1] ] = 'O';

# Reset the map.
for my $row ( 0 .. $rows - 1 ) {
  for my $col ( 0 .. $cols - 1 ) {
    $map[ $row ][ $col ] = '.' if $map[ $row ][ $col ] eq 'X';
  }
}
$map[ $guard[0] ][ $guard[1] ] = '^';

# say join '', @$_ for @map;
# exit;

my $max_iteration = 0;

# Crossing my fingers I don't introduce an infinite loop.
while ( 1 ) {
  # Mark the guard's current (soon to be previous) position.
  $map[ $guard[0] ][ $guard[1] ] = $movements[ $guard[2] ][3];

  # Get the guard's next space.
  my @next = ( $guard[0] + $movements[ $guard[2] ][0], $guard[1] + $movements[ $guard[2] ][1] );

  # If the guard has left the map, we're done.
  last if $next[0] < 0 || $next[0] >= $rows || $next[1] < 0 || $next[1] >= $cols;

  # If the next position is the same as the direction we're moving, we've hit a loop.
  if ( $map[ $guard[0] ][ $guard[1] ] eq $map[ $next[0] ][ $next[1] ] ) {
    say 'Loop detected';
    # say '';
    # say join '', @$_ for @map;
    exit;
  }

  # If the guard is blocked, turn them to the right and try again.
  if ( $map[ $next[0] ][ $next[1] ] =~ /^#|O$/ ) {
    $guard[2] = ($guard[2] + 1) % @movements;
    next;
  }

  # Move the guard.
  @guard[ 0, 1 ] = @next;

  # Mark the guard's new position.
  $map[ $guard[0] ][ $guard[1] ] = $movements[ $guard[2] ][2];

  # This is probably way higher than it needs to be.
  if ( $max_iteration++ > 1_000_000 ) {
    say 'Loop detected - probably, too many iterations';
    exit;
  }
}

say 'Guard has left the lab';

# Print the final map, because it looks cool.
# say '';
# say join '', @$_ for @map;
