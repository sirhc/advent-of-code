#!/usr/bin/env perl

use v5.40;
use strict;
use Smart::Comments;

my ( $input ) = map { chomp; $_ } <>;

### get_ulam_coords($input): get_ulam_coords($input)

sub get_ulam_coords {
  my ( $n ) = @_;
  
  return (0, 0) if $n <= 1;  # base case: origin

  # The spiral is composed of square rings. Ring k ends at n = (2k + 1)^2. We find k for our input by reversing that formula.
  my $k = int((sqrt($n - 1) + 1) / 2);

  # Determine the anchor point. The value (2k + 1)^2 is always at the bottom-right corner (k, -k).
  my $end_n = (2 * $k + 1)**2;
  
  # Current coordinates at the end of the ring.
  my ($x, $y) = ($k, -$k);
  
  # Trace backwards from the anchor to find n. The side length of ring k is 2k.
  my $side_len = 2 * $k;
  my $delta = $end_n - $n;

  # Bottom Side: Moving Left (x decreases).
  if ( $delta < $side_len ) {
    return ($x - $delta, $y);
  }
  $delta -= $side_len;
  $x -= $side_len;  # move x to the bottom-left corner

  # Left Side: Moving Up (y increases).
  if ( $delta < $side_len ) {
    return ($x, $y + $delta);
  }
  $delta -= $side_len;
  $y += $side_len; # move y to the top-left corner.

  # Top Side: Moving Right (x increases).
  if ( $delta < $side_len ) {
    return ($x + $delta, $y);
  }
  $delta -= $side_len;
  $x += $side_len; # move x to the top-right corner

  # Right Side: Moving Down (y decreases).
  return ($x, $y - $delta);
}
