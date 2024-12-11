#!/usr/bin/env perl

use v5.40;
use strict;

use List::Util qw( sum );
use Memoize;
use Data::Dump;

my $blinks = shift @ARGV // 1;
my @stones = map { split / / } map { split /\n/ } do { local $/; <> };

memoize('count_stones');

sub count_stones {
  my ( $stone, $blink ) = @_;

  return 1 if $blink == 0;

  # dd $stone, $blink;

  if ( $stone eq '0' ) {
    return count_stones( '1', $blink - 1 );
  }

  if ( ( length $stone ) % 2 == 0 ) {
    return count_stones( ( substr $stone, 0, ( length $stone ) / 2 ) + 0, $blink - 1 ) + count_stones( ( substr $stone, ( length $stone ) / 2 ) + 0, $blink - 1 );
  }

  return count_stones( $stone * 2024, $blink - 1 );
}

say sum map { count_stones( $_, $blinks ) } @stones;
