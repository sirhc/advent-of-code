#!/usr/bin/env perl

use v5.40;
use strict;
use List::Util qw( reduce );

my @banks = map { chomp; [ split // ] } <>;

for ( @banks ) {
  my ( $one, $two ) = largest_joltage_locations( $_ );
  say render_bank( $_, $one, $two );
}

sub largest_joltage_locations {
  my ( $bank ) = @_;
  my ( $one, $two );

  # Find the first index of the largest number in the bank.
  my $index = reduce { $bank->[$b] > $bank->[$a] ? $b : $a } 0 .. $#$bank;

  if ( $index == $#$bank ) {
    # If the largest number is at the end of the bank, find the second largest number from the left.
    $one = reduce { $bank->[$b] > $bank->[$a] ? $b : $a } 0 .. $#$bank - 1;
    $two = $index;
  }
  else {
    # Otherwise, we look for the largest number to the right of the one we found.
    $one = $index;
    $two = reduce { $bank->[$b] > $bank->[$a] ? $b : $a } $index + 1 .. $#$bank;
  }

  return ( $one, $two );
}

sub render_bank {
  my ( $bank, $one, $two ) = @_;

  my $ptrs = [ (' ') x @$bank ];
  $ptrs->[$one] = '^';
  $ptrs->[$two] = '^';

  return sprintf "%s -> %d%d\n%s", ( join '', @$bank ), $bank->[$one], $bank->[$two], ( join '', @$ptrs );
}
