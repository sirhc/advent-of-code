#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( sum );
use Smart::Comments;

my ( $input ) = map { chomp; $_ } <>;

# 147  142  133  122   59
# 304    5    4    2   57
# 330   10    1    1   54
# 351   11   23   25   26
# 362  747  806--->   ...

### check: get_stored_value(0, 0) == 1
### check: get_stored_value(1, 0) == 1
### check: get_stored_value(1, 1) == 2
### check: get_stored_value(0, 1) == 4
### check: get_stored_value(-1, 1) == 5
### check: get_stored_value(-1, 0) == 10
### check: get_stored_value(-1, -1) == 11
### check: get_stored_value(0, -1) == 23
### check: get_stored_value(1, -1) == 25
### check: get_stored_value(2, -1) == 26
### check: get_stored_value(2, 0) == 54
### check: get_stored_value(2, 1) == 57
### check: get_stored_value(2, 2) == 59
### check: get_stored_value(1, 2) == 122
### check: get_stored_value(0, 2) == 133
### check: get_stored_value(-1, 2) == 142
### check: get_stored_value(-2, 2) == 147
### check: get_stored_value(-2, 1) == 304
### check: get_stored_value(-2, 0) == 330
### check: get_stored_value(-2, -1) == 351
### check: get_stored_value(-2, -2) == 362
### check: get_stored_value(-1, -2) == 747
### check: get_stored_value(0, -2) == 806
### check: get_stored_value(1, -2) == 880
### check: get_stored_value(2, -2) == 931

# Start at ring 2 and work our way around in the order in which squares are populated (see below).
my ( $k, $x, $y, $v ) = 2;

LOOP:
while ( 1 ) {
  $x = $k;  # right
  for ( $y = -$k + 1; $y <= $k; $y += 1 ) {
    $v = get_stored_value($x, $y);
    say sprintf '(%d, %d) => %d', $x, $y, $v;
    last LOOP if $v > $input;
  }

  $y = $k;  # top
  for ( $x = $k - 1; $x >= -$k; $x -= 1 ) {
    $v = get_stored_value($x, $y);
    say sprintf '(%d, %d) => %d', $x, $y, $v;
    last LOOP if $v > $input;
  }

  $x = -$k;  # left
  for ( $y = $k - 1; $y >= -$k; $y -= 1 ) {
    $v = get_stored_value($x, $y);
    say sprintf '(%d, %d) => %d', $x, $y, $v;
    last LOOP if $v > $input;
  }

  $y = -$k;  # bottom
  for ( $x = -$k + 1; $x <= $k; $x += 1 ) {
    $v = get_stored_value($x, $y);
    say sprintf '(%d, %d) => %d', $x, $y, $v;
    last LOOP if $v > $input;
  }

  $k += 1;
}

sub get_stored_value {
  my ( $x, $y ) = @_;

  # Base cases: center value and first ring.
  return 1 if $x == 0 && $y == 0;
  return 1 if $x == 1 && $y == 0;
  return 2 if $x == 1 && $y == 1;
  return 4 if $x == 0 && $y == 1;
  return 5 if $x == -1 && $y == 1;
  return 10 if $x == -1 && $y == 0;
  return 11 if $x == -1 && $y == -1;
  return 23 if $x == 0 && $y == -1;
  return 25 if $x == 1 && $y == -1;

  # Determine which "ring" (k) the coordinates fall into. The ring is determined by the coordinate with the largest absolute value.
  my $k = (abs($x) > abs($y)) ? abs($x) : abs($y);

  # With the base case of the first ring hard-coded above, subsequent rings are populated in the following order:
  #
  #  8  7  6  5  4
  #  9  .  .  .  3
  # 10  .  .  .  2
  # 11  .  .  .  1
  # 12 13 14 15 16

  if ( $y == -$k && $x == $k ) { # position 16
    return sum map { get_stored_value(@$_) } [$x - 1, $y], [$x - 1, $y + 1], [$x, $y + 1];
  }

  if ( $x == $k && $y == -$k + 1 ) { # position 1
    return sum map { get_stored_value(@$_) } [$x - 1, $y], [$x - 1, $y + 1];
  }

  if ( $x == $k && $y <= $k - 2 ) { # position 2
    return sum map { get_stored_value(@$_) } [$x, $y - 1], [$x - 1, $y - 1], [$x - 1, $y], [$x - 1, $y + 1];
  }

  if ( $x == $k && $y <= $k - 1 ) { # position 3
    return sum map { get_stored_value(@$_) } [$x, $y - 1], [$x - 1, $y - 1], [$x - 1, $y];
  }

  if ( $x == $k && $y == $k ) { # position 4
    return sum map { get_stored_value(@$_) } [$x, $y - 1], [$x - 1, $y - 1];
  }

  if ( $y == $k && $x >= -$k + 2 ) { # position 5, 6
    return sum map { get_stored_value(@$_) } [$x + 1, $y], [$x + 1, $y - 1], [$x, $y - 1], [$x - 1, $y - 1];
  }

  if ( $y == $k && $x >= -$k + 1 ) { # position 7
    return sum map { get_stored_value(@$_) } [$x + 1, $y], [$x + 1, $y - 1], [$x, $y - 1];
  }

  if ( $y == $k && $x == -$k ) { # position 8
    return sum map { get_stored_value(@$_) } [$x + 1, $y], [$x + 1, $y - 1];
  }

  if ( $x == -$k && $y >= -$k + 2 ) { # position 9, 10
    return sum map { get_stored_value(@$_) } [$x + 1, $y - 1], [$x + 1, $y], [$x + 1, $y + 1], [$x, $y + 1];
  }

  if ( $x == -$k && $y >= -$k + 1 ) { # position 11
    return sum map { get_stored_value(@$_) } [$x + 1, $y], [$x + 1, $y + 1], [$x, $y + 1];
  }

  if ( $x == -$k && $y == -$k ) { # position 12
    return sum map { get_stored_value(@$_) } [$x + 1, $y + 1], [$x, $y + 1];
  }

  if ( $y == -$k && $x <= $k - 1 ) { # position 13, 14, 15
    return sum map { get_stored_value(@$_) } [$x - 1, $y], [$x - 1, $y + 1], [$x, $y + 1], [$x + 1, $y + 1];
  }

  die;
}
