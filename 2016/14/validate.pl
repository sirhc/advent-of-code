#!/usr/bin/env perl

use v5.40;
use strict;

my @hashes = map { chomp; $_ } <>;
my $found  = 0;

sub get_validator {
  my ( $hashes, $validator, $first, $last ) = @_;

  for ( my $i = $first; $i <= $last; $i++ ) {
    next unless index( $hashes->[$i], $validator ) >= 0;
    return $i;
  }

  return;
}

for ( my $i = 0; $i < @hashes; $i++ ) {
  next unless $hashes[$i] =~ /(.)\1\1/;

  my $validator = get_validator( \@hashes, ( $1 x 5 ), $i + 1, $i + 1000 );
  next unless defined $validator;

  say join ',', $i, $hashes[$i], $validator, $hashes[$validator];

  last if ++$found >= 64;
}
