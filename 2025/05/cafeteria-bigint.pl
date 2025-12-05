#!/usr/bin/env perl

use v5.40;
use strict;
use Math::BigInt;

undef $/;

my $input       = <>; chomp $input;
my @ranges      = map { [ map { Math::BigInt->new($_) } split '-' ] } split "\n", ( split /\n\n/, $input )[0];
my @ingredients = map { Math::BigInt->new($_) } split "\n", ( split /\n\n/, $input )[1];

for my $ingredient ( @ingredients ) {
  my @fresh = ();

  for my $range ( @ranges ) {
    if ( $ingredient >= $range->[0] && $ingredient <= $range->[1] ) {
      push @fresh, $range;
    }
  }

  if ( @fresh ) {
    say sprintf '%s: fresh %s', $ingredient, ( join ' ', map { sprintf '[%s–%s]', @$_ } @fresh );
    next;
  }

  say sprintf '%s: spoiled', $ingredient;
}
