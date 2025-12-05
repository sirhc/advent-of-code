#!/usr/bin/env perl

use v5.40;
use strict;

undef $/;

my $input       = <>; chomp $input;
my @ranges      = map { [ split '-' ] } split "\n", ( split /\n\n/, $input )[0];
my @ingredients = split "\n", ( split /\n\n/, $input )[1];

sub compare {
  my ( $left, $right ) = @_;

  return -1 if length $left > length $right;  # e.g.,  10 < 100
  return  1 if length $left < length $right;  # e.g., 100 >  10

  for ( my $i = 0; $i < length $left; $i++ ) {
    my $ldigit = substr $left,  $i, 1;
    my $rdigit = substr $right, $i, 1;

    return -1 if $ldigit > $rdigit;
    return  1 if $ldigit < $rdigit;
  }

  return 0;
}

for my $ingredient ( @ingredients ) {
  my @fresh = ();

  for my $range ( @ranges ) {
    if ( compare( $ingredient, $range->[0] ) <= 0 && compare( $ingredient, $range->[1] ) >= 0 ) {
      push @fresh, $range;
    }
  }

  if ( @fresh ) {
    say sprintf '%s: fresh %s', $ingredient, ( join ' ', map { sprintf '[%s–%s]', @$_ } @fresh );
    next;
  }

  say sprintf '%s: spoiled', $ingredient;
}
