#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my $blinks = shift @ARGV // 1;
my @rocks  = map { split / / } map { split /\n/ } do { local $/; <> };

say 'Initial arrangement:';
say join ' ', @rocks;
say '';

for my $blink ( 1 .. $blinks ) {
  @rocks = map {
      $_ eq '0'              ? '1'
    : ( length $_ ) % 2 == 0 ? ( ( substr $_, 0, ( length $_ ) / 2 ) + 0, ( substr $_, ( length $_ ) / 2 ) + 0 )
    : $_ * 2024
  } @rocks;

  dd $blink, scalar @rocks;

  # say "After $blink @{[ $blink == 1 ? 'blink' : 'blinks' ]}:";
  # say join ' ', @rocks;
  # say '';
}
