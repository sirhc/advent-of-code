#!/usr/bin/env perl

use v5.40;
use strict;

use Data::Dump;

my @potential = ();  # ( [ index, hash, validator, expiry ] )
my @validated = ();  # ( [ index, hash, validator, expiry, validated_index, validated_hash ] )
my $index     = 0;

while ( defined ( my $hash = <> ) ) {
  chomp $hash;

  for my $candidate ( @potential ) {
    next if $candidate->[3] < $index;  # this candidate has expired

    if ( index( $hash, $candidate->[2] ) >= 0 ) {
      push @validated, [ @$candidate, $index, $hash ];

      $candidate->[3] = -1;  # invalidate the candidate, so we don't use it more than once
    }
  }

  last if scalar @validated >= 64;

  if ( $hash =~ /(.)\1\1/ ) {
    push @potential, [ $index, $hash, ( $1 x 5 ), $index + 1000 ];
  }

  $index++;
}

say join ',', 'index', 'hash', 'validator_index', 'validator_hash';
say ( join ',', @{ $_ }[0,1,4,5] ) for @validated;
